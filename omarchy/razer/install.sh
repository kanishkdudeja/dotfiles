#!/bin/bash

set -euo pipefail

dry_run=false

usage() {
  cat <<'EOF'
Usage: omarchy/razer/install.sh [--dry-run]

Installs OpenRazer and Polychromatic for a Razer Basilisk V3 Pro.
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
  echo "Omarchy is not installed; refusing to install Razer support." >&2
  exit 1
fi

target_user="${SUDO_USER:-${USER:-$(id -un)}}"

user_has_openrazer_group() {
  id -nG "$target_user" | tr ' ' '\n' | grep -qx openrazer
}

if $dry_run; then
  echo "Would install the matching Arch kernel headers: linux-headers"
  echo "Would install Polychromatic from the AUR and its OpenRazer dependencies"

  if user_has_openrazer_group; then
    echo "Unchanged: $target_user is already in the openrazer group"
  else
    echo "Would add $target_user to the openrazer group"
  fi

  echo "Would verify the OpenRazer packages and DKMS mouse driver"
  exit 0
fi

omarchy pkg add linux-headers
omarchy pkg aur add polychromatic

if ! omarchy pkg present \
  linux-headers \
  openrazer-daemon \
  openrazer-driver-dkms \
  python-openrazer \
  polychromatic; then
  echo "One or more required Razer packages are missing after installation." >&2
  exit 1
fi

if user_has_openrazer_group; then
  echo "Unchanged: $target_user is already in the openrazer group"
else
  if ! getent group openrazer >/dev/null; then
    echo "The OpenRazer package did not create the openrazer group." >&2
    exit 1
  fi

  sudo gpasswd -a "$target_user" openrazer
  echo "Added $target_user to the openrazer group."
fi

if modinfo razermouse >/dev/null 2>&1; then
  echo "OpenRazer's razermouse module is available for the running kernel."
else
  echo "Warning: razermouse is not yet available for the running kernel." >&2
  echo "Reboot into the newly installed kernel, then check: modinfo razermouse" >&2
fi

cat <<'EOF'

Razer support is installed. Reboot before opening Polychromatic so the DKMS
driver and openrazer group membership take effect. Then set the mouse to:
  DPI:          500
  Polling rate: 1000 Hz
EOF
