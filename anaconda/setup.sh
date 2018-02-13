if ! [ -x "$(command -v anaconda)" ]; then
  check_brew
  echo_green 'Installing Anaconda(Python)...'
  brew cask install anaconda
fi

echo '# Add anaconda3 to PATH' >> ~/.bash_profile
echo 'export PATH="/usr/local/anaconda3/bin:$PATH"' >> ~/.bash_profile

echo '# Add anaconda3 to PATH' >> ~/.zshrc
echo 'export PATH="/usr/local/anaconda3/bin:$PATH"' >> ~/.zshrc
