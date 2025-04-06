#!/bin/zsh

if [[ "$(uname -s)" == "Linux" ]]; then
    echo "Installing Git via Apt"
    sudo apt update -y
    sudo apt install -y git
fi

echo "Creating symlinks for git configuration"
ln -sf ~/dotfiles/git/.gitconfig-personal ~/.gitconfig-personal
ln -sf ~/dotfiles/git/.gitconfig-work ~/.gitconfig-work
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

echo "Git configuration finished"
