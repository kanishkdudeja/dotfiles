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

# Function to install fonts on Linux
install_fonts_linux() {
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

# Function to install fonts on macOS
install_fonts_macos() {
    mkdir -p ~/Library/Fonts/nerd-fonts
    cd ~/Library/Fonts/nerd-fonts

    for font in "${fonts[@]}"; do
        if [ ! -d "$font" ]; then
            echo "Installing $font..."
            curl -sL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip" -o "$font.zip"
            unzip -o "$font.zip" -d "$font"
            rm "$font.zip"
        else
            echo "$font is already installed, skipping..."
        fi
    done
}

if [[ "$(uname -s)" == "Linux" && ! "$(uname -r | grep -q 'microsoft')" ]]; then
    echo "Proceeding to install fonts on Linux"
    install_fonts_linux
    echo "Fonts installed successfully on Linux"
elif [[ "$(uname -s)" == "Darwin" ]]; then
    echo "Proceeding to install fonts on MacOS"
    install_fonts_macos
    echo "Fonts installed successfully on macOS"
fi




