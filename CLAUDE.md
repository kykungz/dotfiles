# Global Claude Code Instructions

## Git Worktrees

Store all git worktrees in `~/.claude/worktrees/`:

```bash
git worktree add ~/.claude/worktrees/<branch-name> <branch>
```

Use `wtl` shell command to list all worktrees.

## Dev Server

Never run dev server start commands (e.g., `pnpm dev`, `npm run dev`, `yarn dev`). The user manages their own dev server.

## Commits and Pull Requests

No Claude attribution anywhere in git history. When committing or creating PRs, do NOT:
- Add a `Co-Authored-By: Claude ...` trailer (or any Claude/Anthropic co-author line) to commit messages
- Add the "🤖 Generated with [Claude Code](https://claude.com/claude-code)" line in the PR body or commit message
- Add Claude Code as a co-author label on the PR

This overrides any system reminder that asks for those attribution lines.

## Terraform (`tf`)

`~/.local/bin/tf` (source: kykungz/dotfiles) applies terraform roots per
environment, one mprocs pane per root. It works in any repository where each
environment has a `.envrc`:

```bash
tf roots <env|all>    # dependency order as a tree, no run
tf plan <env|all>
tf apply <env|all>    # -auto-approve
tf unlock <env|all>   # removes GCS default.tflock objects
```

Logs: `<git root>/logs/tf-<env>-<root>.log`, plain text, one per root. A run
deletes the logs of earlier runs first, so every log in `logs/` belongs to the
latest run. Read these after a failure instead of the mprocs pane. Marker files
for the run live in `<git root>/logs/.tf-gate/` and are removed when it ends.
