# Kongpon C. dotfiles
This repository contains configurations, applications and tools when migrating to a new macOS environment. All the setups are based on [Kongpon's](https://github.com/kykungz) preferences, and might not be most people's favorite. Think carefully before running the scripts.

## ⚠️ Warning
**DO NOT** run the setup snippet if you don't fully understand what it does. It might cause your programs to malfunction due to the configuration files that will be replaced throughout the installation.

## ⏬ Installation
1. Open *Terminal* (in your Applications)
2. Paste the following script and hit Enter
```bash
bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)"
```
*Please do not modify the script, otherwise the setup will not perform expectedly.*

## 📦 Module Installation
In case you want to install only a part of this setup, for example, only `atom` or `iterm2`.

| Description | Script |
|-|-|
| Applications, Environments and CLIs | `bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)" apps`
| Atom's packages and settings | `bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)" atom`
| Anaconda3 (Python) | `bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)" anaconda`
| Powerline Fonts | `bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)" fonts`
| iTerm2 themes and settings | `bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)" iterm`
| Pip packages | `bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)" pip`
| Yarn packages | `bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)" yarn`
| Oh-my-zsh plugins and settings | `bash -c "$(curl -LsS https://raw.github.com/kykungz/dotfiles/master/setup-remote.sh)" zsh`

## ❓ What will be installed
### Package Manager
- Homebrew

### Shell Related
- Zsh
- oh-my-zsh
- iTerm2

### Environment
- Java (JDK)
- Node / NPM
- Anaconda3 (Python)

### Dependency Manager
- Yarn

### Command Line Interface (CLIs)
- heroku
- unrar
- z
- hub
- archey
- tree
- ngrok
- mas
- vue-cli
- create-react-app
- create-react-native-app
- express-generator
- gitmoji-cli
- nodemon
- kradan

### Text Editor
- Atom
- TextMate

### Development Tools
- Eclipse
- Netbeans
- Android Studio
- Sequel Pro
- SourceTree
- Postman
- Docker

### Browser
- Google Chrome

### Messenger
- Skype

### Entertainment
- VLC

### Utilities
- Google Drive File Stream
- The Unarchiver

### Atom Packages
- Sublime-Style-Column-Selection
- advanced-open-file
- atom-beautify
- atom-html-preview
- atom-jest-snippets
- autocomplete-modules
- busy-signal
- color-picker
- emmet
- file-icons
- highlight-selected
- intentions
- jquery-snippets
- language-vue
- language-x86-64-assembly
- linter
- linter-clang
- linter-eslint
- linter-python
- linter-ui-default
- minimap
- pigments
- platformio-ide-terminal
- react
- script
- standardjs-snippets
- todo-show
- v-bootstrap4
- vue-format

## ✏️ TODO
- Add StandardJS to global setting
- Add update environment command ex. `~/dotfiles/update.sh`
