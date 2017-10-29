if [ ! -e "/Applications/iTerm.app" ]; then
	check_brew
  echo_red 'iTerm2 not found.'
  echo_green 'Installing iTerm2...'
  brew cask install iterm2
fi

source ~/environment-setup/fonts/setup.sh

cp -f ~/environment-setup/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/
