#!/bin/zsh

fonts=(
  "JetBrainsMono"
  "Meslo"
  "Hack"
  "SpaceMono"
  "FiraCode"
  "SourceCodePro"
)

font_directory="$HOME/Library/Fonts/nerd-fonts"
mkdir -p "$font_directory"
cd "$font_directory"

for font in "${fonts[@]}"; do
  if [[ ! -d "$font" ]]; then
    echo "Installing $font..."
    curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" -o "$font.zip"
    unzip -o "$font.zip" -d "$font"
    rm "$font.zip"
  else
    echo "$font is already installed, skipping..."
  fi
done

echo "Fonts installed successfully on macOS"
