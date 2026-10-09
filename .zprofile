# Login-shell environment: PATH and exported variables only.
# Interactive setup (prompt, plugins, completions, aliases) lives in ~/.zshrc.

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Rust (rustup)
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Solana
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# pnpm global packages (mprocs, prettier, ...). The `pnpm` binary itself is resolved
# per project: mise's hook wins in a mise project, nvm's corepack shim (added later, in
# ~/.zshrc) wins in a corepack project, and this global one serves everywhere else.
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# User executables (tf, claude, ...)
export PATH="$HOME/.local/bin:$PATH"
