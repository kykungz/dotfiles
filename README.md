# Kongpon C. dotfiles

A minimal macOS development environment setup script. This repository contains a single command that configures your entire development environment based on [Kongpon's](https://github.com/kykungz) preferences.

## ⚠️ Warning

**DO NOT** run the setup script if you don't fully understand what it does. It will:
- Install Homebrew and numerous applications
- Replace your shell configuration files
- Modify system keyboard shortcuts and preferences
- Install fonts and terminal themes

This might cause your programs to malfunction due to the configuration files that will be replaced throughout the installation.

## ⏬ Installation

Open Terminal and run:

```bash
bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/main/install-remote.sh)"
```

That's it! One command sets up your entire development environment.

## 📦 What gets installed

### Package Manager & Tools
- **Homebrew** - macOS package manager
- **Git** - Version control
- **GitHub CLI** - GitHub command line interface
- **wget** - File downloader
- **ccat** - Colored cat
- **httpie** - HTTP client
- **eza** - Modern ls replacement
- **direnv** - Environment management
- **pnpm** - Fast package manager
- **bun** - JavaScript runtime
- **tree** - Directory structure viewer

### Applications
- **BetterZip** - Archive utility
- **Docker** - Containerization platform
- **ImageOptim** - Image optimization
- **Slack** - Team communication
- **Telegram** - Messaging
- **Cloudflare Warp** - VPN
- **Google Chrome** - Web browser
- **iTerm2** - Terminal emulator
- **Spotify** - Music streaming
- **TextMate** - Text editor
- **Discord** - Gaming communication
- **Google Cloud SDK** - Cloud tools
- **Rectangle** - Window management
- **TablePlus** - Database client
- **Visual Studio Code** - Code editor
- **Cursor** - AI-powered editor
- **ChatGPT** - AI assistant

### Shell & Terminal
- **Oh My Zsh** - Zsh framework
- **Powerlevel10k** - Zsh theme
- **Meslo Nerd Font** - Programming font
- **zsh-autosuggestions** - Command suggestions
- **zsh-syntax-highlighting** - Syntax highlighting
- **zsh-nvm** - Node version manager

### System Preferences
- Caps Lock → Control key mapping
- Custom keyboard shortcuts for:
  - Previous input source: `Cmd+Space`
  - Spotlight: `Option+Space`
  - Mission Control spaces: `Control+←/→`
- Finder settings optimization
- Terminal and TextMate dark themes
- Git auto-setup remote configuration

## 🔄 Updating

To backup your current configuration files:

```bash
bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/main/update.sh)"
```

## 🤝 Contributing

This setup is highly personalized. Feel free to fork and modify for your own needs, but please don't submit pull requests unless you're fixing bugs or adding universally useful features.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
