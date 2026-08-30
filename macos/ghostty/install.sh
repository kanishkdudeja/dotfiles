#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

mkdir -p "$HOME/.config/ghostty"
ln -sf "$dotfiles_root/macos/ghostty/config" "$HOME/.config/ghostty/config"

echo "Ghostty configuration finished"
