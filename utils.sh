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

check_brew() {
  if ! [ -x "$(command -v brew)" ]; then
    echo_red "Homebrew not found."
    echo_green "Installing Homebrew..."
    # Redirect stdin from dev/null to by pass prompting for RETURN
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
    brew tap caskroom/cask
    brew doctor
    brew update
  fi
}

prompt_install() {
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
}
