#!/bin/sh
# To execute: save and `chmod +x ./brew-install-script.sh` then `./brew-install-script.sh`

echo "Installing brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
echo 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
brew install zsh zsh-completions

echo 'Installing iterm2....'
brew cask install iterm2

# Editor
brew install neovim/neovim/neovim
brew cask install caskroom/cask/visual-studio-code

# Dev tools
brew cask install robomongo
brew cask search postman
brew cask install graphiql

# Browser
brew cask install google-chrome
brew cask install firefox

# Messenger
brew cask install telegram
brew cask install slack

# Utilities
brew install unrar
brew install p7zip
brew cask install sourcetree
brew cask install dropbox
brew cask install transmit
brew cask install evernote
brew cask install parallels-desktop
brew cask install microsoft-office
brew cask install duet
brew install wine --without-x11
brew install mono

# Design
brew cask install sketch

# Entertain
brew cask install openemu
brew cask install xld 
brew install ecm