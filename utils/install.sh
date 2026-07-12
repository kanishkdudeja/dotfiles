#!/bin/zsh

# Linux (Includes WSL)
if [[ "$(uname -s)" == "Linux" ]]; then
  echo "Installing Linux packages via Apt"

  sudo apt update -y

  # Install useful applications and utilities
  sudo apt install -y curl unzip gparted dnsutils bat vlc ripgrep zoxide plocate btop fastfetch gpg fd-find

  # Create symlink for fd
  ln -s $(which fdfind) ~/.local/bin/fd

  # Install Eza (a modern replacement for ls)
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt update
  sudo apt install -y eza
fi

# MacOS
if [[ "$(uname -s)" == "Darwin" ]]; then
  echo "Installing MacOS packages via Brew"
  brew install gh wget unison yt-dlp tldr tree speedtest-cli htop btop jq tmux fastfetch bat eza fd jesseduffield/lazydocker/lazydocker jesseduffield/lazygit/lazygit
  brew install autozimu/homebrew-formulas/unison-fsmonitor
fi

# WSL specific installs
if uname -r |grep -q 'microsoft' ; then
    echo "Installing the keychain packages for WSL"
    sudo apt install keychain
fi

echo "Utilities successfully installed"
