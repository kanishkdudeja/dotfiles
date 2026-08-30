#!/bin/zsh

set -e

repo_root="${0:A:h:h}"

if [[ ! -r /etc/os-release ]]; then
  echo "Cannot identify this operating system; refusing the Pop!_OS install." >&2
  exit 1
fi

source /etc/os-release
if [[ "${ID:-}" != "pop" ]]; then
  echo "This installer only supports Pop!_OS; detected ${PRETTY_NAME:-unknown}." >&2
  exit 1
fi

if (( $# > 0 )); then
  echo "Usage: zsh popos/install.sh" >&2
  exit 2
fi

export DOTFILES_ROOT="$repo_root"

source "$repo_root/popos/ssh/install.sh"
source "$repo_root/popos/directories/install.sh"

source "$repo_root/popos/git/install.sh"
source "$repo_root/popos/ghostty/install.sh"
source "$repo_root/popos/tmux/install.sh"
source "$repo_root/popos/vim/install.sh"
source "$repo_root/popos/utils/install.sh"

source "$repo_root/popos/oh-my-zsh-plugins/install.sh"
source "$repo_root/popos/oh-my-posh/install.sh"
source "$repo_root/popos/starship/install.sh"

source "$repo_root/popos/fzf/install.sh"
source "$repo_root/popos/nerd-fonts/install.sh"

# Optional application scripts under popos/apps are intentionally not run by
# default because they are not all idempotent.

echo "Both Oh My Posh and Starship prompts have been configured. Enable the one you would like to use in ~/.zshrc"
echo "Pop!_OS configuration completed. Please restart your terminal."
