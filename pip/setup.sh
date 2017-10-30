if ! [ -x "$(command -v anaconda)" ]; then
  echo_red 'Anaconda(Python) not found.'
  source ~/environment-setup/anaconda/setup.sh
fi

echo_green "Installing packages from pip..."
pip install $(tr '\n' ' ' < ~/environment-setup/pip/packages.txt)
