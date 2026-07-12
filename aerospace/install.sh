#!/bin/zsh

if [[ "$(uname -s)" == "Darwin" ]]; then
  if ! command -v aerospace >/dev/null 2>&1; then
    echo "Installing AeroSpace via Homebrew"
    brew install --cask nikitabobko/tap/aerospace
  fi

  echo "Creating symlink for AeroSpace configuration"
  mkdir -p ~/.config/aerospace
  ln -sf ~/dotfiles/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml

  echo "AeroSpace configuration finished"
fi
