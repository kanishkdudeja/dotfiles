# macOS configuration

This directory contains Homebrew packages, AeroSpace, Ghostty, Nerd Fonts,
Zsh aliases, the OrbStack/Apple SSH configuration, and the personal Supabase
tmux session. Platform-neutral configuration is sourced from `shared/`.

Install Homebrew first, then run from the repository root:

```sh
bash install.sh macos
```

Running `bash install.sh` without a platform argument also detects macOS. The
installer checks for Darwin before making changes and refuses to run on Linux.

Notable macOS-only files:

- `aerospace/`: AeroSpace configuration and installer.
- `ghostty/`: macOS Ghostty configuration.
- `ssh/config`: OrbStack include and Apple `UseKeychain` configuration.
- `tmux/supa.sh`: personal Supabase tmux development session.
