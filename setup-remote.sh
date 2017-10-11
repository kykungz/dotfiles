YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check for existance of Xcode Command Line Interface
if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
   test -d "${xpath}" && test -x "${xpath}" ; then
   #... is correctly installed
   git clone https://github.com/kykungz/environment-setup.git ~/environment-setup
   bash ~/environment-setup/setup-mac.sh
   rm -rf ~/environment-setup
else
   #... isn't correctly installed
   printf "${RED}Command Line Tools is required.${NC}\n"
   printf "${GREEN}Opening installation...${NC}"
   xcode-select --install
fi
