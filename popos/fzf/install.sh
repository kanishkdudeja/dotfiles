#!/bin/zsh

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Clone the fzf repository and run the install command if not already installed
if ! command_exists fzf; then
  echo "Fzf not installed. Cloning the fzf repository..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

  echo "Running the fzf install script..."
  ~/.fzf/install --all
fi

# Looks like this is not needed (flag --all passed to fzf does this already)
# if ! grep -q "source <(fzf --zsh)" ~/.zshrc; then
#   echo "# Set up fzf key bindings and fuzzy completion" >> ~/.zshrc
#   echo "source <(fzf --zsh)" >> ~/.zshrc
# fi

echo "fzf installation and setup complete!"
