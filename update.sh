#!/bin/bash

cp "$HOME/.p10k.zsh" .
cp "$HOME/.zshrc" .
cp "$HOME/Library/Preferences/com.googlecode.iterm2.plist" .
cp "$HOME/Library/Application Support/Cursor/User/keybindings.json" .
cp "$HOME/Library/Application Support/k9s/plugins.yaml" .
jq -S . "$HOME/Library/Application Support/Cursor/User/settings.json" > settings.json
cursor --list-extensions > extensions.txt
