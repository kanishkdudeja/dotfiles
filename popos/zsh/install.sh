#!/bin/bash

if [[ ! -r /etc/os-release ]]; then
  echo "Cannot identify this operating system; refusing the Pop!_OS Zsh install." >&2
  exit 1
fi

source /etc/os-release
if [[ "${ID:-}" != "pop" ]]; then
  echo "This installer only supports Pop!_OS; detected ${PRETTY_NAME:-unknown}." >&2
  exit 1
fi

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

dotfiles_root="${DOTFILES_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"

# Install Curl if it's not installed
if ! command_exists curl; then
  echo "Curl is not installed. Installing curl..."
  sudo apt update && sudo apt install -y curl
fi

# Install Zsh if it's not installed
if ! command_exists zsh; then
  echo "Zsh is not installed. Installing Zsh..."
  sudo apt update && sudo apt install -y zsh
else
  echo "Zsh is already installed."
fi

# Set Zsh as the default shell if it is not
if [ -n "$ZSH_VERSION" ]; then
  echo "Zsh is already the default shell."
else
  echo "Setting Zsh as the default shell..."
  chsh -s "$(which zsh)"
fi

# Install Oh My Zsh if it's not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is not installed. Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh is already installed."
fi

ln -sf "$dotfiles_root/popos/zsh/aliases" ~/.zsh_aliases
ln -sf "$dotfiles_root/popos/zsh/config" ~/.zsh_config

# Check if the line already exists in ~/.zshrc
if ! grep -qxF 'source ~/.zsh_aliases' ~/.zshrc; then
  echo "source ~/.zsh_aliases" >> ~/.zshrc
fi

# Check if the line already exists in ~/.zshrc
if ! grep -qxF 'source ~/.zsh_config' ~/.zshrc; then
  echo "source ~/.zsh_config" >> ~/.zshrc
fi

echo "Zsh configuration completed."
echo "Log out and log back in again to use your new default shell."
