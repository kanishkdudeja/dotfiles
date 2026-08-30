#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

# Function to install Starship
install_starship() {
    if ! command -v starship &> /dev/null; then
        echo "Installing Starship prompt..."
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
    else
        echo "Starship is already installed."
    fi
}

# Symlink the tracked Starship config (minimal Catppuccin Powerline).
configure_starship() {
    echo "Symlinking Starship configuration..."
    mkdir -p ~/.config
    ln -sf "$dotfiles_root/shared/starship/starship.toml" ~/.config/starship.toml
}

# Add the init line to ~/.zshrc, commented, so you can enable Starship by
# uncommenting it (same pick-your-prompt pattern as oh-my-posh).
update_shell_config() {
	if ! grep -q 'eval "$(starship init zsh)"' "$HOME/.zshrc"; then
		echo "Updating Zsh configuration to initialize Starship..."

        # Add configuration but comment it since we will enable it later
		echo '# eval "$(starship init zsh)"' >> "$HOME/.zshrc"
	else
		echo "Starship is already configured in ZSH configuration."
	fi
}

# Install Starship
install_starship

# Configure Starship
configure_starship

# Update shell configuration
update_shell_config

echo "Starship prompt installed and configuration symlinked successfully!"
