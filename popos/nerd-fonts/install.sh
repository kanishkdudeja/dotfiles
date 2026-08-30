#!/bin/zsh

# Array of Nerd Fonts to install
fonts=(
    "JetBrainsMono"
    "Meslo"
    "Hack"
    "SpaceMono"
    "FiraCode"
    "SourceCodePro"
)

install_fonts() {
    mkdir -p ~/.local/share/fonts/nerd-fonts
    cd ~/.local/share/fonts/nerd-fonts

    for font in "${fonts[@]}"; do
        if [ ! -d "$font" ]; then
            echo "Installing $font..."
            wget -q "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" -O "$font.zip"
            unzip -o "$font.zip" -d "$font"
            rm "$font.zip"
        else
            echo "$font is already installed, skipping..."
        fi
    done

    fc-cache -fv
}

echo "Proceeding to install fonts on Pop!_OS"
install_fonts
echo "Fonts installed successfully on Pop!_OS"
