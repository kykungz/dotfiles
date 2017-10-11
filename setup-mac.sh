# Created by Kongpon Charanwattanakit
# https://github.com/kykungz

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Reset (No Color)

echo_red() {
  printf "##### ${RED}${1}${NC}\n"
}

echo_green() {
  printf "##### ${GREEN}${1}${NC}\n"
}

echo_yellow() {
  printf "##### ${YELLOW}${1}${NC}\n"
}

# Installation Confirmation
echo_green "The installation is about to start..."
echo_red "DO NOT turn off your Mac during the installation."
printf "##### ${GREEN}Do you wish to continue${NC} (Y/n)? "
read -r REPLY
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo_red "Installation stopped."
  exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

echo_green "Starting installation...."

echo_green "Creating ~/Developer directory in $HOME"
mkdir ~/Developer

echo;echo;

echo_green "Installing Homebrew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew doctor
brew update

echo;echo;

echo_green "Installing oh-my-zsh..."
brew install zsh zsh-completions
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp -Rf ./zsh/themes ~/.oh-my-zsh/custom
cp -f ./zsh/.zshrc ~/.zshrc
cat ./zsh/_alias >> ~/.zshrc
cat ./zsh/_functions >> ~/.zshrc
cat ./zsh/_dependencies >> ~/.zshrc

echo;echo;

echo_green "Installing iTerm2..."
brew cask install iterm2
cp -f ./iterm/com.googlecode.iterm2.plist ~/Library/Preferences/

echo;echo;

echo_green "Running brew/setup.sh..."
source ./brew/setup.sh

echo;echo;

echo_green "Running yarn/setup.sh..."
source ./yarn/setup.sh

echo;echo;

echo_green "Running atom/setup.sh..."
source ./atom/setup.sh

echo;echo;

echo_green 'Your setup is about to finish!'
echo_green 'Just a few configurations and you are ready to go!'

echo;echo;

echo_green "Setting up your git profile..."
echo_green "Enter your GitHub name:"
read -r name
git config --global user.name "${name}"
echo_green "Enter your GitHub email:"
read email
git config --global user.email ${email}

echo;echo;

echo_green "Enter your password then hit Enter"
echo_green "in order to change the default shell."
chsh -s /bin/zsh

echo;echo;

echo_green 'Installation finished !!'
echo_green 'Try to restart your Mac complete the process.'
echo_green 'Enjoy your new Mac !!'

open -a "/Applications/Google Chrome.app" 'https://github.com/kykungz/environment-setup/blob/master/UNLISTED.md'
