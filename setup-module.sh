YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check for existance of Xcode Command Line Interface
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}" ; then
   #... is correctly installed
   rm -rf ~/environment-setup
   git clone https://github.com/kykungz/environment-setup.git ~/environment-setup
   echo;echo;
   #  bash ~/environment-setup/${1}/setup.sh
   echo "${0} ${1} ${2} ${3}"
   rm -rf ~/environment-setup
else
   #... isn't correctly installed
   printf "##### ${RED}Xcode Command Line Tools is required.${NC}\n"
   printf "##### ${RED}Run the script again after finished installing.${NC}\n"
   printf "##### ${GREEN}Opening installation...${NC}"
   xcode-select --install
fi
