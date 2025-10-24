#!/bin/bash

# Clone the dotfiles repository
rm -rf ~/dotfiles
git clone --single-branch https://github.com/kykungz/dotfiles.git ~/dotfiles

# Run the setup script
~/dotfiles/install.sh

# Clean up
rm -rf ~/dotfiles
