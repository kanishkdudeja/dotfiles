#!/bin/zsh

# Make a directory to store Ghostty config
mkdir -p ~/.config/ghostty/

# Symlink the config file
ln -sf ~/dotfiles/ghostty/config ~/.config/ghostty/config
