# Omarchy configuration

This directory contains the personal configuration ported from Omarchy 3 to
Omarchy 4. The default `all` install is configuration-only and does not run any
of the repository's legacy Debian/Pop!_OS components. Optional application and
Razer components install packages only when explicitly selected.

## Omarchy 4 files

- `hypr/bindings.lua`: Option/Hyper semantic workspaces, stock Caps/Super
  window management, and macOS-style Command shortcuts.
- `hypr/input.lua`: Caps/Super, Option/Hyper, repeat, mouse, and touchpad settings.
- `hypr/monitors.lua`: the Dell and LG 4K monitor layout.
- `hypr/workspaces.lua`: persistent workspaces and application routing.
- `shell.json`: Omarchy shell layout, idle timings, and CPU/btop widget.
- `plugins/kanishk.workspaces/`: semantic workspace labels for one or two monitors.
- `ghostty.conf`: font size and keybindings layered over Omarchy's Ghostty config.
- `apps/install.sh`: optional personal applications installed through Omarchy.
- `razer/install.sh`: optional OpenRazer and Polychromatic installation.

The older `.conf`, `waybar/`, `hypridle`, and `hyprlock` files remain as an
Omarchy 3 reference. The Omarchy 4 installer never installs them.

## Install

Run one component at a time from the repository root. Omarchy does not install
Zsh by default, so the dedicated installer uses Bash:

```sh
bash omarchy/install.sh hypr
bash omarchy/install.sh shell
bash omarchy/install.sh ghostty
```

Preview or install everything:

```sh
bash omarchy/install.sh --dry-run all
bash omarchy/install.sh all
```

Install optional applications or Razer mouse support explicitly:

```sh
bash omarchy/install.sh --dry-run apps
bash omarchy/install.sh apps
bash omarchy/install.sh --dry-run razer
bash omarchy/install.sh razer
```

The apps component installs Chrome, Cursor, Dropbox, Ghostty, Codex, and
Voxtype and restores the tracked Omarchy defaults. The Razer component installs
kernel headers, OpenRazer, and Polychromatic; it may invoke `sudo` to add the
current user to the `openrazer` group.

On a machine where Zsh is already installed, the root dispatcher is also
available:

```sh
zsh install.sh omarchy --dry-run all
```

Existing targets are copied to timestamped `.bak.<timestamp>.<pid>` files
before replacement. Configuration is copied rather than symlinked so Omarchy's
own editors and bar commands can safely rewrite user-owned files.

With both configured monitors connected, the workspace widget shows
`1 2 B C N P S` on the Dell and `M T W` on the LG. With either monitor used
alone, its bar shows all ten workspaces. Workspace placement remains entirely
in Hyprland's `hypr/workspaces.lua`; the plugin controls presentation only.

The physical modifier model matches the macOS setup: Command handles
application shortcuts, Option switches semantic workspaces, and
Option+Shift moves a window silently to the selected workspace. Option+Tab
returns to the former workspace. Caps Lock emits Super and retains Omarchy's
stock window-management and numbered-workspace shortcuts.

The configuration components only write under `~/.config` and never modify
`/usr/share/omarchy`. Package installation and `sudo` are confined to the
explicit optional components described above.

## Validation

The installer parses all Lua and JSON sources before copying them. When run in
an active Hyprland session, the Hypr component also reloads Hyprland and checks
`hyprctl configerrors`. Ghostty configuration is validated before and after its
overlay is enabled.
