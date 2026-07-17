#!/bin/zsh

if [[ "$(uname -s)" == "Linux" ]]; then
    echo "Installing Tmux via apt"
    sudo apt update -y
    sudo apt install -y tmux
fi

echo "Creating symlink for Tmux configuration file"
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

# Install TPM (Tmux Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "TPM not installed. Installing..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install/update plugins declared in .tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins

echo "TMUX configuration finished"
