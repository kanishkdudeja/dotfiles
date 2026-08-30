#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
ln -sf "$dotfiles_root/macos/ssh/config" "$HOME/.ssh/config"

echo "macOS SSH configuration finished"
