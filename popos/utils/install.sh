#!/bin/zsh

echo "Installing Pop!_OS packages via Apt"

sudo apt update -y
sudo apt install -y \
  bat \
  btop \
  curl \
  dnsutils \
  fastfetch \
  fd-find \
  git \
  gparted \
  gpg \
  plocate \
  ripgrep \
  tmux \
  unzip \
  vim \
  vlc \
  wget \
  zoxide

mkdir -p "$HOME/.local/bin"
ln -sfn "$(command -v fdfind)" "$HOME/.local/bin/fd"

# Install Eza (a modern replacement for ls).
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

echo "Utilities successfully installed"
