if ! [ -x "$(command -v hub)" ]; then
  check_brew
  echo_red 'hub not found.'
  echo_green 'Installing hub...'
  brew install hub
fi

if ! [ -x "$(command -v archey)" ]; then
  check_brew
  echo_red 'archey not found.'
  echo_green 'Installing archey...'
  brew install archey
fi

if ! [ -x "$(command -v z)" ]; then
  check_brew
  echo_red 'z not found.'
  echo_green 'Installing z...'
  brew install z
fi

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
