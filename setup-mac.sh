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

echo;echo;

echo_green "Creating ~/Developer directory in $HOME"
mkdir ~/Developer

echo;echo;

echo_green "Installing Homebrew..."
# Redirect stdin from dev/null to by pass prompting for RETURN
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
brew tap caskroom/cask
brew doctor
brew update

echo;echo;

echo_green "Installing oh-my-zsh..."
0>/dev/null sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp -Rf ~/environment-setup/zsh/themes ~/.oh-my-zsh/custom
cp -f ~/environment-setup/zsh/.zshrc ~/.zshrc

cat ~/environment-setup/zsh/.alias >> ~/.zshrc
cat ~/environment-setup/zsh/.functions >> ~/.zshrc
cat ~/environment-setup/zsh/.dependencies >> ~/.zshrc
cat ~/environment-setup/bash/.dependencies >> ~/.bash_profile

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions

echo;echo;

echo_green "Installing Powerline Fonts..."
rm -rf ~/fonts
git clone https://github.com/powerline/fonts ~/fonts
source ~/fonts/install.sh
rm -rf ~/fonts

echo;echo;

echo_green "Installing iTerm2..."
brew cask install iterm2

echo;echo;

echo_green "Running brew/setup.sh..."
source ~/environment-setup/brew/setup.sh

echo;echo;

echo_green "Running yarn/setup.sh..."
source ~/environment-setup/yarn/setup.sh

echo;echo;

echo_green "Installing Atom packages..."
apm install --packages-file ~/environment-setup/atom/packages.txt

echo;echo;

echo_green "Running pip/setup.sh..."
source ~/environment-setup/pip/setup.sh
echo '# Add python3 to env\nexport PATH="/usr/local/anaconda3/bin:$PATH"' >> ~/.bash_profile

echo;echo;

echo_green "Overiding apps settings..."
cp -f ~/environment-setup/atom/config.cson ~/.atom/config.cson
cp -f ~/environment-setup/atom/keymap.cson ~/.atom/keymap.cson
cp -f ~/environment-setup/atom/styles.less ~/.atom/styles.less

cp -f ~/environment-setup/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/

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

open -a "/Applications/Google Chrome.app" 'https://github.com/kykungz/environment-setup/blob/master/ADDITIONAL_STEP.md'
