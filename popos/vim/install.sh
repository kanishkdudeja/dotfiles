#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

if [[ "$(uname -s)" == "Linux" ]]; then
    echo "Installing Vim via apt"
	sudo apt update -y
    sudo apt install -y vim
fi

echo "Creating symlink for VIM configuration file"
ln -sf "$dotfiles_root/popos/vim/.vimrc" ~/.vimrc

echo "VIM configuration finished"
