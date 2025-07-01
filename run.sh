#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile;

# Formulae
brew install git gh wget ccat httpie eza direnv;

# Casks
brew install --cask betterzip docker imageoptim slack telegram cloudflare-warp google-chrome iterm2 spotify textmate discord google-cloud-sdk rectangle tableplus visual-studio-code;

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;

# Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm;

# Meslo Nerd Font patched for Powerlevel10k
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf --output ~/Library/Fonts/'MesloLGS NF Regular.ttf';
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf --output ~/Library/Fonts/'MesloLGS NF Bold.ttf';
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf --output ~/Library/Fonts/'MesloLGS NF Italic.ttf';
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf --output ~/Library/Fonts/'MesloLGS NF Bold Italic.ttf';

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;
cp ./.p10k.zsh $HOME/;

# iTerm2
cp ./com.googlecode.iterm2.plist $HOME/Library/Preferences/;

# ZSH
cp ./.zshrc $HOME/;

# Set Terminal default shell to Bash
defaults write com.apple.Terminal Shell "/bin/sh";
