RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'
NC='\033[0m' # Reset (No Color)

echo_default() {
  printf "##### ${1}\n"
}

echo_red() {
  printf "##### ${RED}${1}${NC}\n"
}

echo_green() {
  printf "##### ${GREEN}${1}${NC}\n"
}

echo_yellow() {
  printf "##### ${YELLOW}${1}${NC}\n"
}

echo
echo_default "The installation is about to start..."
printf "##### ${GREEN}Do you wish to continue${NC} (Y/n)? "
read -r REPLY
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo_red "Installation stopped."
  exit 1 || return 1
fi
echo_green "Starting installation...."
echo

# Check for existence of Xcode Command Line Interface
if [ ! -d "$(xcode-select -p)" ]; then
  echo_red "Xcode Command Line Tools is required."
  echo_green "Opening installation..."
  xcode-select --install &>/dev/null
  while ! xcode-select -p &>/dev/null; do
    sleep 5
  done
  echo_green "Done installing Xcode Command Line Tools."
else
  echo_green "Xcode Command Line Tools is already installed"
fi

# Check for existence of Homebrew
if ! [ -x "$(command -v brew)" ]; then
  echo_red "Homebrew not found."
  echo_green "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew update >/dev/null
  echo_green "Done installing Homebrew"
else
  echo_green "Homebrew is already installed"
fi

# Check for existence of Node.js
if ! [ -x "$(command -v node)" ]; then
  echo_red "Node.js not found."
  echo_green "Installing Node.js..."
  brew install node >/dev/null
  echo_green "Done installing Node.js"
else
  echo_green "Node.js is already installed"
fi

# Check for existence of Yarn
if ! [ -x "$(command -v yarn)" ]; then
  echo_red "Yarn not found."
  echo_green "Installing Yarn..."
  brew install yarn >/dev/null
  echo_green "Done installing Yarn"
else
  echo_green "Yarn is already installed"
fi

node ~/dotfiles/dotfiles.js
