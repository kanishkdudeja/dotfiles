# Omarchy 4 macOS-style keybindings

This document records the personal Omarchy 4 keyboard and workspace setup. It
targets Hyprland's Lua configuration and the Omarchy Quickshell desktop.

## Keyboard model

| Physical key | Hyprland modifier | Purpose |
| --- | --- | --- |
| Caps Lock | `SUPER` | Omarchy shortcuts and semantic workspaces |
| Windows key | `MOD3`/Hyper | macOS-style Option navigation |
| Alt beside Space | `ALT` | macOS-style Command application shortcuts |

The mapping lives in `omarchy/hypr/input.lua`:

```lua
hl.config({
  input = {
    kb_options = "caps:super,altwin:hyper_win",
    repeat_rate = 40,
    repeat_delay = 600,
    sensitivity = 0,
    accel_profile = "flat",
    touchpad = { scroll_factor = 0.4 },
  },
})
```

## Application shortcuts

Hyprland consumes these Alt chords and sends Ctrl shortcuts to the focused
application:

| Physical shortcut | Delivered shortcut | Intended action |
| --- | --- | --- |
| Alt+C | Ctrl+Insert | Copy |
| Alt+V | Ctrl+V | Paste |
| Alt+X | Ctrl+X | Cut |
| Alt+A | Ctrl+A | Select all |
| Alt+Z | Ctrl+Z | Undo |
| Alt+Shift+Z | Ctrl+Shift+Z | Redo |
| Alt+S | Ctrl+S | Save |
| Alt+Shift+S | Ctrl+Shift+S | Save as |
| Alt+F | Ctrl+F | Find |
| Alt+W | Ctrl+W | Close tab or document |
| Alt+T | Ctrl+T | New tab |
| Alt+N | Ctrl+N | New window |
| Alt+L | Ctrl+L | Address or location bar |
| Alt+left-click | Ctrl+left-click | Open link in a new tab |
| Alt+R | Ctrl+R | Reload |
| Alt+Shift+T | Ctrl+Shift+T | Reopen closed tab |
| Alt+P | Ctrl+P | Print |
| Alt+0 | Ctrl+0 | Reset zoom |
| Alt+- | Ctrl+- | Zoom out |
| Alt+= | Ctrl+= | Zoom in |

Alt+Space opens Omarchy 4's native apps menu. Alt+Return opens the Omarchy
menu. The full Lua definitions live in `omarchy/hypr/bindings.lua`.

Copy uses Ctrl+Insert so physical Ctrl+C remains available for terminal
interrupts. The Ghostty overlay maps Ctrl+Insert to copy and maps the other
translated Ctrl shortcuts to Ghostty actions.

## Word navigation

The Windows key emits Hyper/MOD3 and acts like the macOS Option key:

| Physical shortcut | Delivered shortcut | Action |
| --- | --- | --- |
| Windows+Left | Ctrl+Left | Previous word |
| Windows+Right | Ctrl+Right | Next word |
| Windows+Shift+Left | Ctrl+Shift+Left | Select previous word |
| Windows+Shift+Right | Ctrl+Shift+Right | Select next word |
| Windows+Backspace | Ctrl+Backspace | Delete previous word |

These bindings are repeatable, so holding an arrow or Backspace continues the
operation.

## Semantic workspaces

| Physical shortcut | Workspace | Monitor | Routed application |
| --- | --- | --- | --- |
| Caps+1 | `1` Freeform | Dell | None |
| Caps+2 | `2` Freeform | Dell | None |
| Caps+B | `B` Browser | Dell | Google Chrome |
| Caps+C | `C` Cursor | Dell | Cursor |
| Caps+M | `M` Music | LG | Spotify |
| Caps+N | `N` Notes | Dell | Obsidian |
| Caps+P | `P` Personal | Dell | None |
| Caps+S | `S` Slack | Dell | Slack |
| Caps+T | `T` Terminal | LG | Ghostty |
| Caps+W | `W` WhatsApp | LG | WhatsApp |

The Dell is matched by `desc:Dell Inc. AW2725QF 51GD934`; the LG is matched by
`desc:LG Electronics LG ULTRAGEAR 308NTLE7U344`. All workspaces remain visible
when empty. New application windows move silently to their assigned workspace.

The semantic shortcuts displace several Omarchy defaults:

| Personal shortcut | Action | Replaced Omarchy binding |
| --- | --- | --- |
| Caps+Q | Close active window | Caps+W |
| Caps+Shift+T | Toggle floating/tiling | Caps+T |
| Caps+Shift+S | Toggle scratchpad | Google Maps |
| Caps+Shift+P | Pseudo window | Google Photos |
| Alt+C | Copy | Caps+C universal copy |

Super+Shift+B is changed from the regular browser to a private browser, and
Super+Shift+W is changed from Omawrite to WhatsApp.

## Omarchy shell

Omarchy 4 replaces Waybar with the Quickshell-based Omarchy shell. The tracked
`omarchy/shell.json` keeps the stock Agents and Display widgets, adds the old
CPU/btop launcher, starts the screensaver after 150 seconds, and locks after
300 seconds.

The user-owned `kanishk.workspaces` plugin replaces the stock numeric-only
workspace widget. With both monitors connected, the Dell bar shows
`1 2 B C N P S` and the LG bar shows `M T W`. When either monitor is used
alone, its bar shows all ten semantic workspaces. Monitor assignment remains
in Hyprland; the plugin only renders labels and switches workspaces.

Waybar CSS, `hypridle.conf`, and `hyprlock.conf` are Omarchy 3 references only
and are not installed.

## Installation and validation

Preview the isolated Omarchy installer:

```sh
bash omarchy/install.sh --dry-run all
```

Install one component at a time:

```sh
bash omarchy/install.sh hypr
bash omarchy/install.sh shell
bash omarchy/install.sh ghostty
```

After Hyprland changes, the installer reloads Hyprland and checks:

```sh
hyprctl configerrors
```

The shell hot-reloads `shell.json`. The Ghostty component validates the active
configuration without replacing Omarchy's stock theme configuration.
