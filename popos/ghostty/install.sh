#!/bin/zsh

# Make a directory to store Ghostty config
mkdir -p ~/.config/ghostty/
dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

# Symlink MacOS's config file
if [[ "$(uname -s)" == "Darwin" ]]; then
    # Symlink the config file
    ln -sf "$dotfiles_root/popos/ghostty/config-mac" ~/.config/ghostty/config
fi

# Linux (Includes WSL)
if [[ "$(uname -s)" == "Linux" ]]; then
    # Symlink the config file
    ln -sf "$dotfiles_root/popos/ghostty/config-linux" ~/.config/ghostty/config
fi
