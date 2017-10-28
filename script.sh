# Installation Confirmation
YELLOW='\033[1;33m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
RED='\033[0;31m'
echo_red() {
  printf "##### ${RED}${1}${NC}\n"
}

echo_green() {
  printf "##### ${GREEN}${1}${NC}"
}

echo_yellow() {
  printf "##### ${YELLOW}${1}${NC}\n"
}

success() {
  printf "${GREEN}✔︎${NC}\n"
}

printf "##### Installing Homebrew... " && success || echo failed
