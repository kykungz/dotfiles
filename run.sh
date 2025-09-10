#!/bin/bash

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile;

# Formulae
brew install git gh wget ccat httpie eza direnv pnpm meetingbar oven-sh/bun/bun;

# Casks
brew install --cask betterzip docker imageoptim slack telegram cloudflare-warp google-chrome iterm2 spotify textmate discord google-cloud-sdk rectangle tableplus visual-studio-code cursor chatgpt;

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended;

# Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting;
git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm;

# Meslo Nerd Font patched for Powerlevel10k
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf --output ~/Library/Fonts/'MesloLGS NF Regular.ttf';
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf --output ~/Library/Fonts/'MesloLGS NF Bold.ttf';
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf --output ~/Library/Fonts/'MesloLGS NF Italic.ttf';
curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf --output ~/Library/Fonts/'MesloLGS NF Bold Italic.ttf';

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;
cp ./.p10k.zsh $HOME/;

# iTerm2
cp ./com.googlecode.iterm2.plist $HOME/Library/Preferences/;

# ZSH
cp ./.zshrc $HOME/;

# Set Terminal default shell to Bash
defaults write com.apple.Terminal Shell "/bin/sh";

# Set TextMate theme to dark
defaults write com.macromates.TextMate themeAppearance -string "dark";

# Set ChatGPT keyboard shortcut to Ctrl+A
defaults write com.openai.chat.plist "KeyboardShortcuts_toggleLauncher" -string '{"carbonKeyCode":0,"carbonModifiers":4096}';

# If the plist doesn't exist or is empty, create the basic structure
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Set Git to auto setup remote
git config --global --type bool push.autoSetupRemote true;

# Previous input source → Cmd+Space
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:60" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:enabled bool true" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:value:parameters:0 integer 32" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:value:parameters:1 integer 49" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:value:parameters:2 integer 1048576" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:60:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Next input source → disabled
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:61" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:enabled bool false" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:parameters:0 integer 32" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:parameters:1 integer 49" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:parameters:2 integer 786432" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:61:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Spotlight → Option+Space
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:64" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:enabled bool true" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:value:parameters:0 integer 32" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:value:parameters:1 integer 49" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:value:parameters:2 integer 524288" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Finder search → disabled
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:65" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:enabled bool false" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:value:parameters:0 integer 32" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:value:parameters:1 integer 49" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:value:parameters:2 integer 1572864" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Change Caps Lock (⇪) key to Control (⌃) key
/usr/libexec/PlistBuddy -c 'Delete com.apple.keyboard.modifiermapping.0-0-0' ~/Library/Preferences/ByHost/.GlobalPreferences.*.plist;
/usr/libexec/PlistBuddy -c 'Add com.apple.keyboard.modifiermapping.0-0-0 array' ~/Library/Preferences/ByHost/.GlobalPreferences.*.plist;
/usr/libexec/PlistBuddy -c 'Add com.apple.keyboard.modifiermapping.0-0-0:0:HIDKeyboardModifierMappingSrc integer 30064771129' ~/Library/Preferences/ByHost/.GlobalPreferences.*.plist;
/usr/libexec/PlistBuddy -c 'Add com.apple.keyboard.modifiermapping.0-0-0:0:HIDKeyboardModifierMappingDst integer 30064771300' ~/Library/Preferences/ByHost/.GlobalPreferences.*.plist;

# Mission Control → Move left a space → Control+←
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:79" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:79 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:79:enabled bool true" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:79:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:79:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:79:value:parameters:0 integer 65535" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:79:value:parameters:1 integer 123" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:79:value:parameters:2 integer 8650752" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:79:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Mission Control → Move left a space → Control+←
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:80" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:80 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:80:enabled bool true" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:80:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:80:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:80:value:parameters:0 integer 65535" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:80:value:parameters:1 integer 123" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:80:value:parameters:2 integer 8781824" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:80:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Mission Control → Move right a space → Control+→
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:81" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:81 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:81:enabled bool true" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:81:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:81:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:81:value:parameters:0 integer 65535" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:81:value:parameters:1 integer 124" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:81:value:parameters:2 integer 8650752" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:81:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Mission Control → Move right a space → Control+→
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:82" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:82 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:82:enabled bool true" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:82:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:82:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:82:value:parameters:0 integer 65535" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:82:value:parameters:1 integer 124" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:82:value:parameters:2 integer 8781824" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:82:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist;

# Disable Desktop shortcuts → Control+1 ... Control+8
for key in 118 119 120 121 122 123 124 125; do
  /usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:$key" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
  /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
  /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:$key:enabled bool false" ~/Library/Preferences/com.apple.symbolichotkeys.plist;
done

# Finder: Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true;

# Finder: When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf";

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false;
