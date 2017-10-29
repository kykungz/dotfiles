if ! [ -x "$(command -v yarn)" ]; then
  check_brew
  echo_red 'Yarn not found.'
  echo_green 'Installing Yarn...'
  brew install yarn
fi

echo_green "Installing CLIs from Yarn..."
yarn global add $(tr '\n' ' ' < ~/environment-setup/yarn/packages.txt)
