# Created by Kongpon Charanwattanakit
# https://github.com/kykungz

source ~/dotfiles/utils.sh

# Installation Confirmation
prompt_install

echo_green "Creating ~/Developer directory in $HOME"
mkdir ~/Developer

echo;echo;

# Homebrew
echo_green "Installing Homebrew..."
# Redirect stdin from dev/null to by pass prompting for RETURN
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
brew tap caskroom/cask
brew doctor
brew update

echo;echo;

# iTerm2
# Powerline fonts
source ~/dotfiles/iterm/setup.sh
echo;echo;

# Applications, Environments and CLIs
# Anaconda3
source ~/dotfiles/apps/setup.sh
echo;echo;

# Pip packages
source ~/dotfiles/pip/setup.sh
echo;echo;

# Yarn packages
source ~/dotfiles/yarn/setup.sh
echo;echo;

# Atom packages and settings
source ~/dotfiles/atom/setup.sh
echo;echo;

# Oh-my-zsh
source ~/dotfiles/zsh/setup.sh
echo;echo;

echo_green 'Your setup is about to finish!'
echo_green 'Just a few configurations and you are ready to go!'

echo;echo;

echo_green "Setting up your git profile..."
echo_green "Enter your GitHub full name:"
read -r name
git config --global user.name "${name}"
echo_green "Enter your GitHub email:"
read email
git config --global user.email ${email}
git config --global hub.protocol https

echo;echo;

echo_green 'Installation finished !!'
echo_green 'Try to restart your Mac complete the process.'
echo_green 'Enjoy your new Mac !!'

open -a "/Applications/Google Chrome.app" 'https://github.com/kykungz/dotfiles/blob/master/ADDITIONAL_STEP.md'
