if ! [ -x "$(command -v apm)" ]; then
  check_brew
  echo_red 'Atom not found.'
  echo_green 'Installing Atom...'
  brew cask install atom
fi

echo_green "Installing Atom packages..."
apm install --packages-file ~/dotfiles/atom/packages.txt

cp -f ~/dotfiles/atom/config.cson ~/.atom/config.cson
cp -f ~/dotfiles/atom/keymap.cson ~/.atom/keymap.cson
cp -f ~/dotfiles/atom/styles.less ~/.atom/styles.less
