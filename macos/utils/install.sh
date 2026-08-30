#!/bin/zsh

echo "Installing macOS packages via Homebrew"
brew install \
  bat \
  btop \
  eza \
  fastfetch \
  fd \
  gh \
  git \
  htop \
  jq \
  jesseduffield/lazydocker/lazydocker \
  jesseduffield/lazygit/lazygit \
  speedtest-cli \
  tldr \
  tmux \
  tree \
  unison \
  vim \
  wget \
  yt-dlp
brew install autozimu/homebrew-formulas/unison-fsmonitor

echo "Utilities successfully installed"
