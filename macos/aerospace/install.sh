#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

if ! command -v aerospace >/dev/null 2>&1; then
  echo "Installing AeroSpace via Homebrew"
  brew install --cask nikitabobko/tap/aerospace
fi

echo "Creating symlink for AeroSpace configuration"
mkdir -p ~/.config/aerospace
ln -sf "$dotfiles_root/macos/aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml

echo "AeroSpace configuration finished"
