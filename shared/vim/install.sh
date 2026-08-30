#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

echo "Creating symlink for VIM configuration file"
ln -sf "$dotfiles_root/shared/vim/.vimrc" ~/.vimrc

echo "VIM configuration finished"
