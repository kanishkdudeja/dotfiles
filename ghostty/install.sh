#!/bin/zsh

# Make a directory to store Ghostty config
mkdir -p ~/.config/ghostty/

# Symlink MacOS's config file
if [[ "$(uname -s)" == "Darwin" ]]; then
    # Symlink the config file
    ln -sf ~/dotfiles/ghostty/config-mac ~/.config/ghostty/config
fi

# Linux (Includes WSL)
if [[ "$(uname -s)" == "Linux" ]]; then
    # Symlink the config file
    ln -sf ~/dotfiles/ghostty/config-linux ~/.config/ghostty/config
fi
