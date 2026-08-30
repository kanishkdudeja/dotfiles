# Repository Guidelines

## Project Structure & Module Organization

This repository has isolated `omarchy/`, `popos/`, and `macos/` setups. The root `install.sh` dispatches to the detected or explicitly selected platform. `shared/` contains platform-neutral components sourced only by Pop!_OS and macOS; Omarchy never sources them. `popos/apps/` contains optional Debian application installers, while `popos/ulauncher/snippets/` stores Jinja snippet templates.

Keep new configuration beside its installer. Add a new component to root `install.sh` only when it is safe to run as part of the standard setup.

## Build, Test, and Development Commands

There is no compilation step or package-managed test suite. Use these commands from the repository root:

- `bash popos/zsh/install.sh` bootstraps Zsh and Oh My Zsh on Pop!_OS.
- `bash install.sh omarchy --dry-run all` previews the Omarchy setup.
- `zsh popos/install.sh` runs the full Pop!_OS setup described in `README.md`.
- `zsh macos/install.sh` runs the full macOS setup described in `README.md`.
- `zsh -n popos/install.sh macos/install.sh popos/*/install.sh macos/*/install.sh shared/*/install.sh` checks Zsh-compatible scripts for syntax errors.
- `bash -n install.sh popos/zsh/install.sh popos/apps/*.sh` checks scripts intended for Bash or simple POSIX-style execution.

Full installers modify files under `$HOME`, install packages, and may invoke `sudo` or download content. Prefer syntax checks and targeted component runs during development.

## Coding Style & Naming Conventions

Use two-space indentation in new shell code, preserve the existing style when editing older files, and quote variable expansions such as `"$HOME"` and `"$file"`. Start executable scripts with the appropriate shebang (`#!/bin/zsh` or `#!/bin/bash`). Name component entry points `install.sh`; name optional application scripts `popos/apps/app-<name>.sh`. Keep platform branches explicit with `uname -s`, and make installers idempotent by checking before appending, cloning, or installing.

## Testing Guidelines

Run the relevant syntax checks before committing. Test platform-specific changes on the affected OS when possible. For symlink installers, verify both the link target and a second run of the script. Never test destructive or privileged operations against a user's existing configuration without reviewing the commands first.

## Commit & Pull Request Guidelines

Recent commits use short, imperative, lowercase summaries, such as `update tmux config` and `add ghostty config`. Keep each commit focused on one component. Pull requests should explain the user-visible change, list tested platforms and commands, call out new dependencies or `sudo` usage, and include screenshots only for visual terminal or prompt changes.
