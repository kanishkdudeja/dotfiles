#!/bin/zsh

echo "Creating ~/.ssh/ directory if not already present"
mkdir -p "$HOME/.ssh"

echo "Setting appropriate permissions for SSH directory"
chmod 700 "$HOME/.ssh"

echo "SSH directory is ready; existing keys and configuration were left unchanged"
