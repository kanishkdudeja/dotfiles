#!/bin/zsh

# Install the Pop!_OS Ghostty configuration.
mkdir -p ~/.config/ghostty/
dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

ln -sf "$dotfiles_root/popos/ghostty/config-linux" ~/.config/ghostty/config
