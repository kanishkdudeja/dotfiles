#!/bin/bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

usage() {
  cat <<'EOF'
Usage: bash install.sh [omarchy|popos] [installer arguments]

With no platform argument, the installer detects Omarchy or Pop!_OS.
EOF
}

is_popos() {
  [[ -r /etc/os-release ]] && (
    source /etc/os-release
    [[ "${ID:-}" == "pop" ]]
  )
}

case "${1:-}" in
  omarchy|popos)
    platform="$1"
    shift
    ;;
  -h|--help|help)
    usage
    exit 0
    ;;
  "")
    if command -v omarchy >/dev/null 2>&1 && [[ -d /usr/share/omarchy ]]; then
      platform="omarchy"
    elif is_popos; then
      platform="popos"
    else
      echo "Unable to detect Omarchy or Pop!_OS." >&2
      usage >&2
      exit 1
    fi
    ;;
  *)
    echo "Unknown platform: $1" >&2
    usage >&2
    exit 2
    ;;
esac

case "$platform" in
  omarchy)
    exec bash "$repo_root/omarchy/install.sh" "$@"
    ;;
  popos)
    if ! command -v zsh >/dev/null 2>&1; then
      echo "Zsh is required. First run: bash popos/zsh/install.sh" >&2
      exit 1
    fi
    exec zsh "$repo_root/popos/install.sh" "$@"
    ;;
esac
