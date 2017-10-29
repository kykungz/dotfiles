RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Reset (No Color)
MODULE=$0

# Check for existance of Xcode Command Line Interface
if type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d "${xpath}" && test -x "${xpath}" ; then
  #... is correctly installed
  rm -rf ~/environment-setup
  git clone https://github.com/kykungz/environment-setup.git ~/environment-setup
  echo;echo;
  if [ "$MODULE" ]; then
    bash -c "
      source ~/environment-setup/utils.sh;
      prompt_install;
      source ~/environment-setup/${MODULE}/setup.sh
      echoecho;
      echo_green Done!"
  else
    bash ~/environment-setup/setup-mac.sh
  fi
  rm -rf ~/environment-setup
else
  #... isn't correctly installed
  echo;echo;
  printf "##### ${RED}Xcode Command Line Tools is required.${NC}\n"
  printf "##### ${RED}Run the script again after finished installing.${NC}\n"
  printf "##### ${GREEN}Opening installation...${NC}"
  xcode-select --install
fi
