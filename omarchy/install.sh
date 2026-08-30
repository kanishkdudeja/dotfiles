#!/bin/bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
backup_suffix="$(date +%Y%m%d%H%M%S).$$"
dry_run=false

usage() {
  cat <<'EOF'
Usage: omarchy/install.sh [--dry-run] [hypr|shell|ghostty|apps|razer|all]

Installs only the Omarchy-specific configuration from this repository.
The optional apps and razer components install packages; all other components
remain configuration-only and never invoke the legacy Pop!_OS setup.
EOF
}

if [[ "${1:-}" == "--dry-run" ]]; then
  dry_run=true
  shift
fi

component="${1:-all}"
if (( $# > 1 )); then
  usage >&2
  exit 2
fi

if ! command -v omarchy >/dev/null 2>&1 || [[ ! -d /usr/share/omarchy ]]; then
  echo "Omarchy is not installed; refusing to install Omarchy configuration." >&2
  exit 1
fi

backup_target() {
  local target="$1"
  local backup="${target}.bak.${backup_suffix}"

  if [[ -e "$target" || -L "$target" ]]; then
    cp -a -- "$target" "$backup"
    echo "Backed up $target to $backup"
  fi
}

install_file() {
  local source="$1"
  local target="$2"

  if [[ -f "$target" ]] && cmp -s -- "$source" "$target"; then
    echo "Unchanged: $target"
    return
  fi

  if $dry_run; then
    echo "Would install $source -> $target"
    return
  fi

  mkdir -p -- "$(dirname "$target")"
  backup_target "$target"
  cp --remove-destination -- "$source" "$target"
  chmod 0644 "$target"
  echo "Installed: $target"
}

validate_lua_sources() {
  local file
  for file in \
    "$repo_root/omarchy/hypr/workspaces.lua" \
    "$repo_root/omarchy/hypr/monitors.lua" \
    "$repo_root/omarchy/hypr/input.lua" \
    "$repo_root/omarchy/hypr/bindings.lua"; do
    luac -p "$file"
  done
}

validate_hyprland_runtime() {
  if $dry_run; then
    return
  fi

  if [[ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
    echo "Hyprland runtime validation skipped: no active Hyprland session detected."
    echo "Later run: hyprctl reload && hyprctl configerrors"
    return
  fi

  hyprctl reload >/dev/null

  local errors
  errors="$(hyprctl configerrors)"
  if [[ -n "${errors//[[:space:]]/}" ]]; then
    echo "$errors" >&2
    return 1
  fi

  echo "Hyprland reloaded with no configuration errors."
}

install_hypr() {
  validate_lua_sources

  # Install workspaces before bindings because bindings.lua requires it.
  install_file "$repo_root/omarchy/hypr/workspaces.lua" "$HOME/.config/hypr/workspaces.lua"
  install_file "$repo_root/omarchy/hypr/monitors.lua" "$HOME/.config/hypr/monitors.lua"
  install_file "$repo_root/omarchy/hypr/input.lua" "$HOME/.config/hypr/input.lua"
  install_file "$repo_root/omarchy/hypr/bindings.lua" "$HOME/.config/hypr/bindings.lua"

  validate_hyprland_runtime
}

install_shell() {
  local plugin_source="$repo_root/omarchy/plugins/kanishk.workspaces"
  local plugin_target="$HOME/.config/omarchy/plugins/kanishk.workspaces"
  local plugin_changed=false

  if [[ ! -f "$plugin_target/manifest.json" ]] \
    || ! cmp -s -- "$plugin_source/manifest.json" "$plugin_target/manifest.json" \
    || [[ ! -f "$plugin_target/Workspaces.qml" ]] \
    || ! cmp -s -- "$plugin_source/Workspaces.qml" "$plugin_target/Workspaces.qml"; then
    plugin_changed=true
  fi

  jq -e . "$repo_root/omarchy/shell.json" >/dev/null
  jq -e . "$plugin_source/manifest.json" >/dev/null

  install_file "$plugin_source/manifest.json" "$plugin_target/manifest.json"
  install_file "$plugin_source/Workspaces.qml" "$plugin_target/Workspaces.qml"

  if ! $dry_run; then
    local attempt
    local discovered=false

    omarchy-shell shell rescanPlugins >/dev/null
    for (( attempt = 0; attempt < 40; attempt++ )); do
      if omarchy plugin list --json | jq -e 'any(.[]; .id == "kanishk.workspaces")' >/dev/null; then
        discovered=true
        break
      fi
      sleep 0.05
    done

    if ! $discovered; then
      echo "Omarchy shell did not discover kanishk.workspaces." >&2
      exit 1
    fi
  fi

  install_file "$repo_root/omarchy/shell.json" "$HOME/.config/omarchy/shell.json"

  if $dry_run && $plugin_changed; then
    echo "Would restart the Omarchy shell to rebuild the changed plugin."
  elif ! $dry_run && $plugin_changed; then
    omarchy restart shell
    echo "Restarted the Omarchy shell to rebuild the changed plugin."
  elif ! $dry_run; then
    echo "The Omarchy shell will hot-reload shell.json automatically."
  fi
}

install_ghostty() {
  local overlay_source="$repo_root/omarchy/ghostty.conf"
  local overlay_target="$HOME/.config/ghostty/dotfiles-omarchy.conf"
  local config="$HOME/.config/ghostty/config"
  local include_line='config-file = ?"~/.config/ghostty/dotfiles-omarchy.conf"'

  ghostty +validate-config --config-file="$overlay_source"

  if [[ ! -f "$config" ]]; then
    echo "Missing $config; install or refresh Ghostty through Omarchy first." >&2
    exit 1
  fi

  install_file "$overlay_source" "$overlay_target"

  if grep -qxF "$include_line" "$config"; then
    echo "Unchanged: Ghostty overlay include"
  elif $dry_run; then
    echo "Would append the Omarchy dotfiles overlay include to $config"
  else
    backup_target "$config"
    printf '\n%s\n' "$include_line" >> "$config"
    echo "Added Ghostty overlay include to $config"
  fi

  if ! $dry_run; then
    ghostty +validate-config
    echo "Ghostty configuration is valid; new terminals will use the changes."
  fi
}

install_razer() {
  if $dry_run; then
    "$repo_root/omarchy/razer/install.sh" --dry-run
  else
    "$repo_root/omarchy/razer/install.sh"
  fi
}

install_apps() {
  if $dry_run; then
    "$repo_root/omarchy/apps/install.sh" --dry-run
  else
    "$repo_root/omarchy/apps/install.sh"
  fi
}

case "$component" in
  hypr)
    install_hypr
    ;;
  shell)
    install_shell
    ;;
  ghostty)
    install_ghostty
    ;;
  apps)
    install_apps
    ;;
  razer)
    install_razer
    ;;
  all)
    install_hypr
    install_shell
    install_ghostty
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage >&2
    exit 2
    ;;
esac
