# Shared Pop!_OS and macOS components

This directory contains platform-neutral configuration used only by
`popos/install.sh` and `macos/install.sh`. It has no top-level installer and is
never sourced by `omarchy/install.sh`.

Shared components include Git, tmux, Vim, fzf, Starship, Oh My Posh, Oh My Zsh
plugins, common Zsh configuration, and the personal `~/kd` directory setup.
Platform-specific packages and configuration remain under `popos/` and
`macos/`.
