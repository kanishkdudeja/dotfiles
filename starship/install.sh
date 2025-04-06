#!/bin/zsh

# Function to install Starship
install_starship() {
    if ! command -v starship &> /dev/null; then
        echo "Installing Starship prompt..."
        sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -y
    else
        echo "Starship is already installed."
    fi
}

# Function to configure Starship with the Pastel Powerline preset
configure_starship() {
    echo "Configuring Starship with the Pastel Powerline preset..."
    mkdir -p ~/.config
    starship_config=~/.config/starship.toml

    if [ ! -f "$starship_config" ]; then
		starship preset pastel-powerline -o ~/.config/starship.toml
        echo "Starship configuration created."
    else
        echo "Starship configuration already exists."
    fi
}

# Function to update shell configuration
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

echo "Starship prompt installed and configured with the Pastel Powerline preset successfully!"
