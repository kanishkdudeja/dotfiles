#!/bin/zsh

set -e

repo_root="${0:A:h:h}"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This installer only supports macOS." >&2
  exit 1
fi

if (( $# > 0 )); then
  echo "Usage: zsh macos/install.sh" >&2
  exit 2
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required before running the macOS installer." >&2
  exit 1
fi

export DOTFILES_ROOT="$repo_root"

source "$repo_root/macos/utils/install.sh"
source "$repo_root/macos/zsh/install.sh"
source "$repo_root/macos/ssh/install.sh"
source "$repo_root/shared/directories/install.sh"

source "$repo_root/shared/git/install.sh"
source "$repo_root/macos/ghostty/install.sh"
source "$repo_root/macos/aerospace/install.sh"
source "$repo_root/shared/tmux/install.sh"
source "$repo_root/shared/vim/install.sh"

source "$repo_root/shared/oh-my-zsh-plugins/install.sh"
source "$repo_root/shared/oh-my-posh/install.sh"
source "$repo_root/shared/starship/install.sh"

source "$repo_root/shared/fzf/install.sh"
source "$repo_root/macos/nerd-fonts/install.sh"

echo "Both Oh My Posh and Starship prompts have been configured. Enable the one you would like to use in ~/.zshrc"
echo "macOS configuration completed. Please restart your terminal."
