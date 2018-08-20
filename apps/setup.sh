check_brew

# Environment
echo_green "Installing Environments..."
brew cask install caskroom/versions/java8 # (java 9 is not supported on Netbeans 8.2)
brew install node
source ~/dotfiles/anaconda/setup.sh

echo_green "Installing Dependency Manager..."
brew install yarn

# Command Line Interface (CLIs)
echo_green "Installing CLIs..."
brew install git
brew install ccat
brew install heroku
brew install unrar
brew install z
brew install hub
brew install archey
brew install tree
brew cask install ngrok
brew install mas
brew install inetutils
brew cask install google-cloud-sdk
brew install kubernetes-cli
brew install httpie
sudo gem install iStats

# Signin App Store
mas signin --dialog ''

# Editor
echo_green "Installing Editors..."
brew cask install atom
brew cask install visual-studio-code
brew cask install textmate

# Development Tools
echo_green "Installing Development Tools..."
brew cask install eclipse-java
brew cask install netbeans-java-se
brew cask install android-studio
brew cask install sequel-pro
brew cask install sourcetree
brew cask install postman
brew cask install docker
mas install 497799835 # Xcode
sudo xcodebuild -license accept

# Browser
echo_green "Installing Browsers..."
brew cask install google-chrome
brew cask install firefox

# Messenger
echo_green "Installing Messengers..."
mas install 539883307 # LINE
brew cask install skype

# Entertainment
echo_green "Installing Entertainments..."
brew cask install vlc

# Utilities
echo_green "Installing Utilities..."
brew cask install google-drive-file-stream
brew cask install betterzip
brew cask install imageoptim
brew cask install kap
mas install 425424353 # The Unarchiver
mas install 736473980 # Paint 2
mas install 409183694 # Keynote
