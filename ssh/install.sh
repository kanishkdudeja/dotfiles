#!/bin/zsh

echo "Creating ~/.ssh/ directory if not already present"
mkdir -p ~/.ssh/

echo "Creating empty files for SSH public and private keys"
touch ~/.ssh/id_ed25519.pub
touch ~/.ssh/id_ed25519

echo "Setting appropriate permissions for SSH directory and keys"
chmod 700 ~/.ssh/
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/id_ed25519

ln -sf ~/dotfiles/ssh/config ~/.ssh/config

echo "SSH Configuration finished"
