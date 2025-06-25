#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile

# CLIs
brew install git gh wget ccat httpie eza

# Casks
brew install --cask betterzip docker imageoptim slack telegram cloudflare-warp google-chrome iterm2 spotify textmate discord google-cloud-sdk rectangle tableplus visual-studio-code

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp ./p10k.zsh $HOME/

# iTerm2
cp ./com.googlecode.iterm2.plist $HOME/Library/Preferences/
