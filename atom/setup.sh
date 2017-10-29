if ! [ -x "$(command -v apm)" ]; then
  check_brew
  echo_red 'Atom not found.'
  echo_green 'Installing Atom...'
  brew cask install atom
fi

echo_green "Installing Atom packages..."
apm install --packages-file ~/environment-setup/atom/packages.txt

cp -f ~/environment-setup/atom/config.cson ~/.atom/config.cson
cp -f ~/environment-setup/atom/keymap.cson ~/.atom/keymap.cson
cp -f ~/environment-setup/atom/styles.less ~/.atom/styles.less
