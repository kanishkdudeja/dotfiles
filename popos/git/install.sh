#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

if [[ "$(uname -s)" == "Linux" ]]; then
    echo "Installing Git via Apt"
    sudo apt update -y
    sudo apt install -y git
fi

echo "Creating symlinks for git configuration"
ln -sf "$dotfiles_root/popos/git/.gitconfig-personal" ~/.gitconfig-personal
ln -sf "$dotfiles_root/popos/git/.gitconfig-work" ~/.gitconfig-work
ln -sf "$dotfiles_root/popos/git/.gitconfig" ~/.gitconfig

echo "Git configuration finished"
