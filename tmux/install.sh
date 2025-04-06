#!/bin/zsh

if [[ "$(uname -s)" == "Linux" ]]; then
    echo "Installing Tmux via apt"
    sudo apt update -y
    sudo apt install -y tmux
fi

echo "Creating symlink for Tmux configuration file"
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

echo "TMUX configuration finished"
