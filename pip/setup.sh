echo_green "Installing packages from pip..."

pip install $(tr '\n' ' ' < ~/environment-setup/pip/packages.txt)
