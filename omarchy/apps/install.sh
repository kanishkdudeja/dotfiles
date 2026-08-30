#!/bin/bash

set -euo pipefail

dry_run=false

usage() {
  cat <<'EOF'
Usage: omarchy/apps/install.sh [--dry-run]

Installs the personal Omarchy application set and restores its defaults.
EOF
}

if [[ "${1:-}" == "--dry-run" ]]; then
  dry_run=true
  shift
fi

if (( $# > 0 )); then
  usage >&2
  exit 2
fi

if ! command -v omarchy >/dev/null 2>&1 || [[ ! -d /usr/share/omarchy ]]; then
  echo "Omarchy is not installed; refusing to install Omarchy applications." >&2
  exit 1
fi

install_chrome() {
  if omarchy pkg present google-chrome; then
    echo "Unchanged: Chrome is installed"
  elif $dry_run; then
    echo "Would run: omarchy install browser chrome"
  else
    omarchy install browser chrome
  fi
}

install_cursor() {
  if omarchy pkg present cursor-bin; then
    echo "Unchanged: Cursor is installed"
  elif $dry_run; then
    echo "Would run: omarchy pkg add cursor-bin"
    echo "Would sync the current Omarchy theme to Cursor"
  else
    omarchy pkg add cursor-bin
    omarchy theme set vscode
  fi
}

install_dropbox() {
  if omarchy pkg present \
    dropbox \
    dropbox-cli \
    libappindicator-gtk3 \
    python-gpgme \
    nautilus-dropbox; then
    echo "Unchanged: Dropbox and its Omarchy dependencies are installed"
  elif $dry_run; then
    echo "Would run: omarchy install service dropbox"
    echo "Dropbox authentication would remain a manual step"
  else
    omarchy install service dropbox
  fi
}

install_ghostty() {
  if omarchy pkg present ghostty; then
    echo "Unchanged: Ghostty is installed"
  elif $dry_run; then
    echo "Would run: omarchy install terminal ghostty"
  else
    omarchy install terminal ghostty
  fi
}

install_codex() {
  local codex_installed=false

  if command -v codex >/dev/null 2>&1 && mise where codex >/dev/null 2>&1; then
    codex_installed=true
  fi

  if $codex_installed; then
    echo "Unchanged: Codex is installed through Mise"
  elif $dry_run; then
    echo "Would run: omarchy mise install codex"
    echo "Would install Codex through Mise without launching it"
  else
    omarchy mise install codex
    mise use -g codex
  fi
}

install_voxtype() {
  if omarchy pkg present wtype voxtype-bin; then
    echo "Unchanged: Voxtype is installed"
  elif $dry_run; then
    echo "Would run interactively: omarchy voxtype install"
    echo "Voxtype would ask before downloading its AI model"
  else
    omarchy voxtype install

    if ! omarchy pkg present wtype voxtype-bin; then
      echo "Voxtype was not installed; re-run this component when ready." >&2
      return 1
    fi
  fi
}

ensure_default() {
  local kind="$1"
  local expected="$2"
  local current

  current="$(omarchy default "$kind")"
  if [[ "$current" == "$expected" ]]; then
    echo "Unchanged: default $kind is $expected"
  elif $dry_run; then
    echo "Would run: omarchy default $kind $expected"
  else
    omarchy default "$kind" "$expected"
  fi
}

ensure_default_agent() {
  local agent_file="$HOME/.config/omarchy/defaults/agent"
  local current

  current="$(omarchy default agent)"
  if [[ "$current" == "codex" ]]; then
    echo "Unchanged: default coding agent is codex"
  elif $dry_run; then
    echo "Would set Codex as the default coding agent without launching it"
  else
    mkdir -p "$(dirname "$agent_file")"
    printf '%s\n' codex > "$agent_file"
    echo "Set Codex as the default coding agent."
  fi
}

install_chrome
install_cursor
install_dropbox
install_ghostty
install_codex

ensure_default browser chrome
ensure_default terminal ghostty
ensure_default editor nvim
ensure_default_agent

# Keep the interactive model download last so all non-interactive apps and
# defaults are handled even if the user chooses not to install Voxtype yet.
install_voxtype
