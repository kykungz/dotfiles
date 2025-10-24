# https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-initialize-direnv-when-using-instant-prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitignore kubectl zsh-autosuggestions zsh-syntax-highlighting zsh-nvm direnv)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Skip powerlevel10k in certain environments
if [[ -n "$CURSOR_AGENT" ]]; then
  ZSH_THEME="simple"
  # Skip theme initialization for better compatibility
else
  ZSH_THEME="powerlevel10k/powerlevel10k"
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ohmyzsh="open ~/.oh-my-zsh"
alias config="mate ~/.zshrc"
alias reload="source ~/.zshrc"
alias for-printing="
	git -C ~/Desktop/for-printing pull origin master;
	git -C ~/Desktop/for-printing add -A;
	git -C ~/Desktop/for-printing commit -m 'Upload';
	git -C ~/Desktop/for-printing push origin master;
"
alias p="pnpm"
alias pn="pnpm"
alias ls="eza --icons"

function myip {
  echo '   'local ip: $(ipconfig getifaddr en0) | grep 'local ip'
  route get default | grep gateway
  echo '  'public ip: $(curl -s ipecho.net/plain) | grep 'public ip'
}
function checkport {
  if [ "$1" ]; then
    lsof -P -n -iTCP -sTCP:LISTEN | grep $1
  else
    lsof -P -n -iTCP -sTCP:LISTEN
  fi
}
function cpr {
  # Fetch source code from gist https://gist.github.com/kykungz/2af9792cf31f36e645f0e85895e4f2b2
  local output=$(bun -e "$(curl -s https://gist.githubusercontent.com/kykungz/2af9792cf31f36e645f0e85895e4f2b2/raw/cpr.ts)")

  # Validate that we have title and body
  local title=$(echo -E "$output" | jq -r '.title // empty' 2>/dev/null)
  local body=$(echo -E "$output" | jq -r '.body // empty' 2>/dev/null)

  if [[ -z "$title" ]] || [[ -z "$body" ]]; then
    echo -e "\nFailed to create a Pull Request"
    return 1
  fi

  # Create the PR using gh CLI, forwarding any additional arguments
  gh pr create --title "$title" --body "$body" "$@"
}
function upr {
  local pr_number=$(gh pr view --json "number" --jq .number)

  if [[ -z "$pr_number" ]]; then
    echo "No pull request found in the current context."
    return 1
  fi

  # Fetch source code from gist https://gist.github.com/kykungz/2af9792cf31f36e645f0e85895e4f2b2
  local output=$(bun -e "$(curl -s https://gist.githubusercontent.com/kykungz/2af9792cf31f36e645f0e85895e4f2b2/raw/cpr.ts)")

  # Validate that we have title and body
  local title=$(echo -E "$output" | jq -r '.title // empty' 2>/dev/null)
  local body=$(echo -E "$output" | jq -r '.body // empty' 2>/dev/null)

  if [[ -z "$title" ]] || [[ -z "$body" ]]; then
    echo -e "\nFailed to update a Pull Request"
    return 1
  fi

  # Update the PR using gh CLI, forwarding any additional arguments
  gh pr edit $pr_number --title "$title" --body "$body" "$@"
}

# Changes hex 0x15 to delete everything to the left of the cursor, rather than the whole line
bindkey "^U" backward-kill-line

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# rustup
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
