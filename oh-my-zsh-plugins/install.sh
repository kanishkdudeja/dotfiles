#!/bin/zsh

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Install Curl if it's not installed
if ! command_exists git; then
  echo "Git is not installed. Installing git..."
  sudo apt update && sudo apt install -y git
fi

# Sourcing ~/.zshrc to be able to access the $ZSH_CUSTOM variable
echo "Sourcing ~/.zshrc to be able to access the ZSH_CUSTOM variable"
source ~/.zshrc

echo "Proceeding to install ZSH plugins"

# Install Zsh Syntax Highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "zsh-syntax-highlighting plugin not installed. Installing..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Install Zsh Auto Suggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "zsh-autosuggestions plugin not installed. Installing..."
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# Enable specific plugins in .zshrc
# "zsh-syntax-highlighting" needs to be the last plugin for it to work correctly
PLUGINS=("git" "colored-man-pages" "copypath" "copyfile" "1password" "web-search" "sudo" "zsh-autosuggestions" "zsh-syntax-highlighting")

ZSHRC="$HOME/.zshrc"
for PLUGIN in "${PLUGINS[@]}"; do
  if ! grep "plugins=(.*$PLUGIN.*)" "$ZSHRC" | grep -q -v '^#'; then # Exclude commented lines as well
    echo "Enabling $PLUGIN plugin in .zshrc..."

    # Add plugins in order to the end of the plugins array in ~/.zshrc
    sed -i "s/plugins=(\(.*\))/plugins=(\1 $PLUGIN)/" "$ZSHRC"
  else
    echo "$PLUGIN plugin is already enabled in .zshrc."
  fi
done

echo "Oh My Zsh configuration completed."
