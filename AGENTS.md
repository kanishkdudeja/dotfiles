# Repository Guidelines

## Project Structure & Module Organization

This repository manages cross-platform shell configuration for macOS and Debian-based Linux. The root `install.sh` orchestrates component installers. Each top-level directory owns one tool or concern: for example, `zsh/`, `git/`, `tmux/`, `vim/`, `ssh/`, and `ghostty/` contain configuration files plus an `install.sh` that installs packages or creates symlinks. `apps/` contains optional Linux application installers, while `ulauncher/snippets/` stores Jinja snippet templates.

Keep new configuration beside its installer. Add a new component to root `install.sh` only when it is safe to run as part of the standard setup.

## Build, Test, and Development Commands

There is no compilation step or package-managed test suite. Use these commands from the repository root:

- `bash zsh/install.sh` bootstraps Zsh and Oh My Zsh.
- `zsh install.sh` runs the full dotfiles setup described in `README.md`.
- `zsh -n install.sh */install.sh` checks Zsh-compatible scripts for syntax errors.
- `bash -n zsh/install.sh apps/*.sh` checks scripts intended for Bash or simple POSIX-style execution.

Full installers modify files under `$HOME`, install packages, and may invoke `sudo` or download content. Prefer syntax checks and targeted component runs during development.

## Coding Style & Naming Conventions

Use two-space indentation in new shell code, preserve the existing style when editing older files, and quote variable expansions such as `"$HOME"` and `"$file"`. Start executable scripts with the appropriate shebang (`#!/bin/zsh` or `#!/bin/bash`). Name component entry points `install.sh`; name optional application scripts `apps/app-<name>.sh`. Keep platform branches explicit with `uname -s`, and make installers idempotent by checking before appending, cloning, or installing.

## Testing Guidelines

Run the relevant syntax checks before committing. Test platform-specific changes on the affected OS when possible. For symlink installers, verify both the link target and a second run of the script. Never test destructive or privileged operations against a user's existing configuration without reviewing the commands first.

## Commit & Pull Request Guidelines

Recent commits use short, imperative, lowercase summaries, such as `update tmux config` and `add ghostty config`. Keep each commit focused on one component. Pull requests should explain the user-visible change, list tested platforms and commands, call out new dependencies or `sudo` usage, and include screenshots only for visual terminal or prompt changes.
