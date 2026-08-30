#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

if ! command -v curl >/dev/null 2>&1 || ! command -v zsh >/dev/null 2>&1; then
  echo "curl and Zsh are required before running the macOS installer." >&2
  return 1
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ln -sf "$dotfiles_root/macos/zsh/aliases" "$HOME/.zsh_aliases"
ln -sf "$dotfiles_root/shared/zsh/config" "$HOME/.zsh_config"

touch "$HOME/.zshrc"
if ! grep -qxF 'source ~/.zsh_aliases' "$HOME/.zshrc"; then
  echo 'source ~/.zsh_aliases' >> "$HOME/.zshrc"
fi
if ! grep -qxF 'source ~/.zsh_config' "$HOME/.zshrc"; then
  echo 'source ~/.zsh_config' >> "$HOME/.zshrc"
fi

echo "Zsh configuration completed."
