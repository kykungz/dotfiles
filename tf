#!/usr/bin/env bun
// tf — terraform roots per environment, one mprocs pane per root.
//
//   tf apply  <env|all> [root ...]   init + apply -auto-approve, all roots (or the named ones)
//   tf plan   <env|all> [root ...]   init + plan
//   tf unlock <env|all>              remove GCS *.tflock objects of the env's state buckets
//   tf roots  <env|all>              print the run order as a tree
//
// Discovery: every directory in the repo with a .tf file that declares a `backend "..."` block is
// a root (modules never declare one). Roots that share a parent directory form an environment,
// named after that parent; a backend block directly in a dev/ or prod/ folder makes that folder
// an environment with one root. The search is a git grep: fast, and it skips ignored paths.
// Untracked files count too.
//
//   <env>/.envrc            sourced before terraform (TF_CLI_ARGS_*, impersonation, ...)
//   <env>/<root>/.envrc     also sourced, when present
//   <env>/<root>/main.tf    one terraform root per directory
//   <env>/.tf-deps          optional: "root: dep dep" lines that override the inferred order
//
// <env> matches an environment name exactly, then by suffix (dev -> nansen-trade-dev), then by
// unique substring. `all` runs every environment.
//
// Root order: a root that reads another root's state through terraform_remote_state (gcs
// prefix or s3 key) waits for that root. A root that uses the kubernetes, helm or kubectl
// provider waits for a sibling named gke, eks, aks or cluster, because its providers read the
// live API during plan. .tf-deps replaces the inferred list for a root.
//
// On a tty every root gets its own mprocs pane; `r` restarts a pane. Without a tty the roots
// run one at a time in dependency order. Each root writes a plain-text log to
// <git root>/logs/tf-<env>-<root>.log; a run first deletes the tf-*.log files of earlier runs,
// so every log in the folder belongs to the latest run. The run's marker files live in
// <git root>/logs/.tf-gate for the duration of the run.
//
// Needs: bun, terraform, mprocs (pnpm add -g mprocs), gcloud (unlock only).

import { existsSync, mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { basename, dirname, join, resolve } from "node:path";
import { $ } from "bun";

const SELF = Bun.main;

// ---------- discovery ----------

type Env = { name: string; dir: string; roots: string[] };

async function gitRoot(): Promise<string> {
  const out = await $`git rev-parse --show-toplevel`.nothrow().quiet();
  return out.exitCode === 0 ? out.text().trim() : fail("not inside a git repository");
}

/** HCL with #, // and block comments removed. */
function stripComments(hcl: string): string {
  return hcl.replace(/\/\*[\s\S]*?\*\//g, "").replace(/^[ \t]*(#|\/\/).*$/gm, "");
}

const BACKEND = /^[ \t]*backend[ \t]+"/m;

/** Absolute directories whose .tf files declare a backend block. */
async function rootDirs(): Promise<string[]> {
  const root = await gitRoot();
  // git grep is the fast prefilter; the file content check drops block-commented matches.
  const listed = await $`git grep -l --untracked -E ${'^[[:space:]]*backend[[:space:]]+"'} -- ${"*.tf"}`.cwd(root).nothrow().quiet().text();
  const files = listed
    .split("\n")
    .filter(Boolean)
    .map((f) => resolve(root, f))
    .filter((f) => BACKEND.test(stripComments(readFileSync(f, "utf8"))));
  return [...new Set(files.map(dirname))].sort();
}

/** Roots grouped by parent directory. */
async function discoverEnvs(): Promise<Env[]> {
  const byParent = new Map<string, string[]>();
  for (const dir of await rootDirs()) byParent.set(dirname(dir), [...(byParent.get(dirname(dir)) ?? []), basename(dir)]);
  const envs = [...byParent].map(([dir, roots]) => ({ name: basename(dir), dir, roots }));
  if (!envs.length) fail(`no .tf file with a backend block under ${await gitRoot()}`);
  return envs;
}

async function resolveEnvs(arg: string): Promise<Env[]> {
  const envs = await discoverEnvs();
  if (arg === "all") return envs;
  const match = (list: Env[]) => {
    let found = list.filter((e) => e.name === arg);
    if (!found.length) found = list.filter((e) => e.name.endsWith(`-${arg}`));
    if (!found.length) found = list.filter((e) => e.name.includes(arg));
    return found;
  };
  let found = match(envs);
  // A backend block directly in dev/ or prod/: that folder is the environment and its only root.
  if (!found.length) found = match(envs.flatMap((e) => e.roots.map((r) => ({ name: r, dir: join(e.dir, r), roots: ["."] }))));
  if (found.length === 1) return found;
  if (found.length === 0) return fail(`no environment matches '${arg}' (known: ${envs.map((e) => e.name).join(" ")})`);
  return fail(`'${arg}' is ambiguous: ${found.map((e) => e.name).join(" ")}`);
}

// ---------- dependencies ----------

function tfSource(dir: string): string {
  return readdirSync(dir)
    .filter((f) => f.endsWith(".tf"))
    .map((f) => readFileSync(join(dir, f), "utf8"))
    .join("\n");
}

/** Dependencies of one root. .tf-deps wins; else inferred from the HCL. */
function depsOf(envDir: string, root: string, siblings: string[]): string[] {
  const depsFile = join(envDir, ".tf-deps");
  if (existsSync(depsFile)) {
    for (const raw of readFileSync(depsFile, "utf8").split("\n")) {
      const line = raw.replace(/#.*/, "");
      const [name, rest] = line.split(":", 2);
      if (name?.trim() === root && rest !== undefined) return rest.trim().split(/\s+/).filter(Boolean);
    }
  }

  const src = tfSource(join(envDir, root));
  const deps = new Set<string>();

  // remote_state: gcs `prefix = "x"` or s3 `key = "x/terraform.tfstate"` where x is a sibling.
  for (const block of src.matchAll(/data\s+"terraform_remote_state"\s+"[^"]*"\s*\{([\s\S]*?)\n\}/g)) {
    for (const ref of block[1].matchAll(/\b(?:prefix|key)\s*=\s*"([^"]+)"/g)) {
      const name = ref[1].split("/")[0].replace(/\.tfstate$/, "");
      if (name !== root && siblings.includes(name)) deps.add(name);
    }
  }

  // Live-API providers wait for the cluster root.
  if (/^\s*provider\s+"(kubernetes|helm|kubectl)"/m.test(src)) {
    const cluster = ["gke", "eks", "aks", "cluster", "kubernetes-cluster", "k8s-cluster"].find(
      (c) => c !== root && siblings.includes(c),
    );
    if (cluster) deps.add(cluster);
  }
  return [...deps];
}

type Ordered = { root: string; deps: string[] };

/** Topological order; ties keep name order. */
function orderedRoots(env: Env): Ordered[] {
  const deps = new Map(env.roots.map((r) => [r, depsOf(env.dir, r, env.roots)]));
  const done: Ordered[] = [];
  let pending = env.roots;
  while (pending.length) {
    const ready = pending.filter((r) => deps.get(r)!.every((d) => done.some((o) => o.root === d)));
    if (!ready.length) fail(`dependency cycle among: ${pending.join(" ")}`);
    for (const r of ready) done.push({ root: r, deps: deps.get(r)! });
    pending = pending.filter((r) => !ready.includes(r));
  }
  return done;
}

// ---------- roots (tree view) ----------

/** A root hangs under the dependency that finishes last. */
function printTree(env: Env): void {
  const order = orderedRoots(env);
  const children = new Map<string, string[]>();
  const top: string[] = [];
  for (const { root, deps } of order) {
    const parent = deps.at(-1);
    if (parent === undefined) top.push(root);
    else children.set(parent, [...(children.get(parent) ?? []), root]);
  }
  console.log(env.name);
  const branch = (root: string, prefix: string, last: boolean) => {
    console.log(`${prefix}${last ? "└── " : "├── "}${root}`);
    const kids = children.get(root) ?? [];
    kids.forEach((k, i) => branch(k, prefix + (last ? "    " : "│   "), i === kids.length - 1));
  };
  top.forEach((r, i) => branch(r, "", i === top.length - 1));
}

// ---------- apply / plan ----------

async function run(action: "apply" | "plan", envs: Env[], only: string[]): Promise<number> {
  const logDir = join(await gitRoot(), "logs");
  // Marker files that order the roots. Fresh on every run, gone when the run ends.
  const gate = join(logDir, ".tf-gate");
  rmSync(gate, { recursive: true, force: true });
  mkdirSync(gate, { recursive: true });
  // Only this run's logs stay, so a stale log from an earlier run cannot be mistaken for a new one.
  for (const f of readdirSync(logDir)) if (/^tf-.*\.log$/.test(f)) rmSync(join(logDir, f));
  const cleanup = () => rmSync(gate, { recursive: true, force: true });
  process.on("exit", cleanup);
  for (const sig of ["SIGINT", "SIGTERM"] as const) process.on(sig, () => process.exit(130));

  const names: string[] = [];
  const commands: string[][] = [];
  for (const env of envs) {
    const envGate = join(gate, env.name);
    mkdirSync(envGate);
    for (const { root, deps } of orderedRoots(env)) {
      if (only.length && !only.includes(root)) {
        // A root that is not in this run is a dependency nobody writes a marker for.
        writeFileSync(join(envGate, `${root}.ok`), "");
        continue;
      }
      names.push(`${env.name}/${root}`);
      commands.push(["bun", SELF, "_root", action, env.dir, root, envGate, logDir, ...deps]);
    }
  }
  if (!names.length) return fail(`${action}: no roots to run`);

  console.error(`logs: ${logDir.replace(`${process.cwd()}/`, "")}/tf-<env>-<root>.log`);
  const tty = process.stdin.isTTY && process.stdout.isTTY;
  if (tty) {
    if (!Bun.which("mprocs")) return fail("mprocs not found (pnpm add -g mprocs)", 127);
    const title = `terraform ${action}`;
    // The sidebar has a fixed width, so size it to the longest name plus the marker and status.
    const config = join(gate, "mprocs.yaml");
    writeFileSync(config, `proc_list_width: ${Math.max(...names.map((n) => n.length), title.length) + 8}\n`);
    const shellWords = (cmd: string[]) => cmd.map((w) => `'${w.replace(/'/g, `'\\''`)}'`).join(" ");
    const proc = Bun.spawn(
      ["mprocs", "-c", config, "--proc-list-title", title, "--names", names.join(","), ...commands.map(shellWords)],
      { stdio: ["inherit", "inherit", "inherit"] },
    );
    return await proc.exited;
  }
  let status = 0;
  for (const cmd of commands) {
    if ((await $`${cmd}`.nothrow()).exitCode !== 0) status = 1;
  }
  return status;
}

/** Environment after sourcing the .envrc of the env dir, then of the root (direnv-style files of exports). */
async function envWithEnvrc(envDir: string, root: string): Promise<Record<string, string>> {
  const env = { ...process.env } as Record<string, string>;
  const files = [join(envDir, ".envrc"), join(envDir, root, ".envrc")].filter((f) => existsSync(f));
  if (!files.length) return env;
  const script = files.map((f) => `source ${JSON.stringify(f)} >/dev/null 2>&1`).join("; ") + "; env -0";
  const out = await $`bash -c ${script}`.cwd(envDir).quiet();
  for (const pair of out.text().split("\0")) {
    const i = pair.indexOf("=");
    if (i > 0) env[pair.slice(0, i)] = pair.slice(i + 1);
  }
  return env;
}

const ANSI = /\x1b\[[0-9;?]*[ -\/]*[@-~]/g;

/** One root, one process. Waits on the markers of its dependencies, then writes its own. */
async function rootProcess(
  action: "apply" | "plan",
  envDir: string,
  root: string,
  gate: string,
  logDir: string,
  deps: string[],
): Promise<number> {
  const env = basename(envDir);
  const label = `${env}/${root}`;
  const log = join(logDir, `tf-${env}-${root.replaceAll("/", "_")}.log`);
  writeFileSync(log, "");
  console.log(`log: ${log}`);

  const procEnv = await envWithEnvrc(envDir, root);
  // Per-root helm registry config: parallel logins race in the shared keychain store.
  procEnv.HELM_REGISTRY_CONFIG = join(gate, `helm-registry-${root.replaceAll("/", "_")}.json`);

  const ok = (d: string) => existsSync(join(gate, `${d}.ok`));
  const failed = (d: string) => existsSync(join(gate, `${d}.failed`));
  for (const dep of deps) {
    if (!ok(dep) && !failed(dep)) {
      console.log(`waiting for ${env}/${dep}`);
      while (!ok(dep) && !failed(dep)) await Bun.sleep(1000);
    }
    if (failed(dep)) {
      console.error(`skipped: ${env}/${dep} failed`);
      writeFileSync(join(gate, `${root}.failed`), "");
      return 1;
    }
  }

  const tfArgs = action === "apply" ? ["apply", "-auto-approve", "-input=false"] : ["plan", "-input=false"];
  const steps = [
    ["terraform", `-chdir=${root}`, "init", "-input=false"],
    ["terraform", `-chdir=${root}`, ...tfArgs],
  ];
  const sink = Bun.file(log).writer();
  sink.write(`# ${new Date().toISOString().replace(/\.\d+Z$/, "Z")} ${label}\n`);
  let status = 0;
  for (const cmd of steps) {
    // The pane keeps terraform's output as is; the file gets the same lines without escapes.
    const proc = Bun.spawn(["bash", "-c", 'exec "$@" 2>&1', "_", ...cmd], { cwd: envDir, env: procEnv, stdout: "pipe" });
    for await (const chunk of proc.stdout) {
      process.stderr.write(chunk);
      sink.write(new TextDecoder().decode(chunk).replace(ANSI, ""));
    }
    status = await proc.exited;
    if (status !== 0) break;
  }
  await sink.end();

  writeFileSync(join(gate, status === 0 ? `${root}.ok` : `${root}.failed`), "");
  if (status !== 0) console.error(`failed: ${label} (log: ${log})`);
  return status;
}

// ---------- unlock ----------

/**
 * The GCS backend keeps one default.tflock object next to the state; removing it is the whole
 * unlock. Buckets come from the backend blocks of each root. Never unlock while an apply runs.
 */
async function unlock(envs: Env[]): Promise<number> {
  if (!Bun.which("gcloud")) return fail("unlock: gcloud not found", 127);
  let status = 0;
  for (const { name: env, dir: envDir, roots } of envs) {
    const src = stripComments(roots.map((r) => tfSource(join(envDir, r))).join("\n"));
    const buckets = new Set<string>();
    for (const block of src.matchAll(/backend\s+"gcs"\s*\{([\s\S]*?)\}/g)) {
      const m = block[1].match(/\bbucket\s*=\s*"([^"]+)"/);
      if (m) buckets.add(m[1]);
    }
    if (!buckets.size) {
      console.error(`${env}: no gcs backend found; tf unlock supports gcs only (use terraform force-unlock <id>)`);
      status = 1;
      continue;
    }
    for (const bucket of buckets) {
      const locks = (await $`gcloud storage ls ${`gs://${bucket}/**.tflock`}`.nothrow().quiet()).stdout
        .toString()
        .split("\n")
        .filter(Boolean);
      if (!locks.length) {
        console.log(`${env}: no locks in gs://${bucket}`);
        continue;
      }
      for (const lock of locks) {
        console.log(`${env}: unlocking ${lock}`);
        await $`gcloud storage cat ${lock}`.nothrow();
        console.log();
        if ((await $`gcloud storage rm ${lock}`.nothrow()).exitCode !== 0) status = 1;
      }
    }
  }
  return status;
}

// ---------- main ----------

function fail(message: string, code = 2): never {
  console.error(`tf: ${message}`);
  process.exit(code);
}

function usage(): void {
  console.log(`usage: tf apply  <env|all> [root ...]
       tf plan   <env|all> [root ...]
       tf unlock <env|all>
       tf roots  <env|all>`);
}

async function main(argv: string[]): Promise<number> {
  const [action, envArg, ...rest] = argv;
  if (action === "_root") {
    const [a, envDir, root, gate, logDir, ...deps] = [envArg, ...rest];
    return rootProcess(a as "apply" | "plan", envDir, root, gate, logDir, deps);
  }
  if (!action || action === "-h" || action === "--help") return (usage(), 0);
  if (!["apply", "plan", "unlock", "roots"].includes(action)) {
    console.error(`tf: unknown action '${action}'`);
    usage();
    return 2;
  }
  if (!envArg) return fail(`${action}: missing <env>`);

  const envs = await resolveEnvs(envArg);
  switch (action) {
    case "roots":
      for (const env of envs) printTree(env);
      return 0;
    case "unlock":
      return unlock(envs);
    default:
      return run(action as "apply" | "plan", envs, rest);
  }
}

process.exit(await main(process.argv.slice(2)));
