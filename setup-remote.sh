RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # Reset (No Color)
MODULE=$0

# Check for existance of Xcode Command Line Interface
if [ ! -d "$(xcode-select -p)" ]; then
  printf "##### ${RED}Xcode Command Line Tools is required.${NC}\n"
  printf "##### ${GREEN}Opening installation...${NC}"
  xcode-select --install &> /dev/null
  while ! xcode-select -p &> /dev/null; do
    sleep 5
  done
  printf "##### ${GREEN}Done installing Xcode Command Line Tools.${NC}"
fi

rm -rf ~/dotfiles
git clone https://github.com/kykungz/dotfiles.git ~/dotfiles
echo;echo;

if [ "$MODULE" && $MODULE != "bash" ]; then
  bash -c "
    source ~/dotfiles/utils.sh;
    echo_green 'Installing module: ${NC}${MODULE}'
    prompt_install;
    source ~/dotfiles/${MODULE}/setup.sh
    echoecho;
    echo_green Done!"
else
  bash ~/dotfiles/setup-mac.sh
fi
