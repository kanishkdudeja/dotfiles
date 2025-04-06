#!/bin/zsh

# Check if Oh My Posh is already installed
if ! command -v oh-my-posh &> /dev/null; then
    echo "Oh My Posh is not installed. Installing Oh My Posh..."
    sudo mkdir -p /usr/local/bin
    curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin
fi

# Create directory for Oh My Posh themes if it doesn't exist
if [ ! -d ~/.oh-my-posh-themes ]; then
    echo "Oh My Posh themes are not installed. Installing..."
    mkdir ~/.oh-my-posh-themes

    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip
    unzip -o -q themes.zip -d ~/.oh-my-posh-themes
    rm themes.zip
fi

# Initialize Oh My Posh with the desired theme
if ! grep -q "oh-my-posh init zsh" ~/.zshrc; then
    echo "Adding Oh My Posh configuration to ~/.zshrc"

    # Add configuration but comment it since we will enable it later
    echo '# eval "$(oh-my-posh init zsh --config ~/.oh-my-posh-themes/M365Princess.omp.json)"' >> ~/.zshrc
fi

echo "Oh My Posh configuration completed."
