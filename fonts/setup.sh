echo_green "Installing Powerline Fonts..."
rm -rf ~/fonts
git clone https://github.com/powerline/fonts.git ~/fonts --depth=1
source ~/fonts/install.sh
rm -rf ~/fonts
