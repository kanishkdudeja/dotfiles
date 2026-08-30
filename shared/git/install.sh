#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

echo "Creating symlinks for git configuration"
ln -sf "$dotfiles_root/shared/git/.gitconfig-personal" ~/.gitconfig-personal
ln -sf "$dotfiles_root/shared/git/.gitconfig-work" ~/.gitconfig-work
ln -sf "$dotfiles_root/shared/git/.gitconfig" ~/.gitconfig

echo "Git configuration finished"
