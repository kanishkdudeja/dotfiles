#!/bin/zsh

dotfiles_root="${DOTFILES_ROOT:-${0:A:h:h:h}}"

if [[ "$(uname -s)" == "Linux" ]]; then
    echo "Installing Tmux via apt"
    sudo apt update -y
    sudo apt install -y tmux
fi

echo "Creating symlink for Tmux configuration file"
ln -sf "$dotfiles_root/popos/tmux/.tmux.conf" ~/.tmux.conf

# Install TPM (Tmux Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
  echo "TPM not installed. Installing..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Themes are loaded by direct path in .tmux.conf (not via @plugin), so TPM
# won't fetch them — clone them explicitly. Do this BEFORE install_plugins,
# which sources the config (and would otherwise hit a missing theme path).
# catppuccin/tmux and dracula/tmux share the basename "tmux", so they get
# distinct target directories.
if [ ! -d ~/.tmux/plugins/tmux ]; then
  git clone https://github.com/catppuccin/tmux.git ~/.tmux/plugins/tmux
fi
if [ ! -d ~/.tmux/plugins/dracula ]; then
  git clone https://github.com/dracula/tmux.git ~/.tmux/plugins/dracula
fi
if [ ! -d ~/.tmux/plugins/tokyo-night ]; then
  git clone https://github.com/janoamaral/tokyo-night-tmux.git ~/.tmux/plugins/tokyo-night
fi
if [ ! -d ~/.tmux/plugins/rose-pine ]; then
  git clone https://github.com/rose-pine/tmux.git ~/.tmux/plugins/rose-pine
fi
if [ ! -d ~/.tmux/plugins/nord ]; then
  git clone https://github.com/nordtheme/tmux.git ~/.tmux/plugins/nord
fi

# Install/update plugins declared via @plugin in .tmux.conf (tpm, tmux-sensible)
~/.tmux/plugins/tpm/bin/install_plugins

echo "TMUX configuration finished"
