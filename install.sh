#!/bin/zsh

# Exit immediately if a command exits with a non-zero status
set -e

source ~/dotfiles/ssh/install.sh
source ~/dotfiles/directories/install.sh

source ~/dotfiles/git/install.sh
source ~/dotfiles/tmux/install.sh
source ~/dotfiles/vim/install.sh
source ~/dotfiles/utils/install.sh

source ~/dotfiles/oh-my-zsh-plugins/install.sh
source ~/dotfiles/oh-my-posh/install.sh
source ~/dotfiles/starship/install.sh

source ~/dotfiles/fzf/install.sh
source ~/dotfiles/nerd-fonts/install.sh

# Commented for now since app install scripts are not idempotent (i.e. apps will be reinstalled if script is run again)
# Linux (Excludes WSL)
# if [[ "$(uname -s)" == "Linux" && ! "$(uname -r | grep -q 'microsoft')" ]]; then
  # Run installers
  # for script in ~/dotfiles/apps/*.sh; do source $script; done
# fi

echo "Both Oh My Posh and Starship prompts have been configured. Enable the one you would like to use in ~/.zshrc"
echo "Configuration completed. Please restart your terminal."
