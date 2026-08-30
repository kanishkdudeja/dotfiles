# Omarchy 4 macOS-style keybindings

This document records the personal Omarchy 4 keyboard and workspace setup. It
targets Hyprland's Lua configuration and the Omarchy Quickshell desktop.

## Keyboard model

| Physical key | Hyprland modifier | Purpose |
| --- | --- | --- |
| Caps Lock | `SUPER` | Stock Omarchy window, system, and numbered-workspace shortcuts |
| Option (Windows/Super keycode) | `MOD3`/Hyper | Semantic workspaces and macOS-style Option navigation |
| Command beside Space (Alt keycode) | `ALT` | macOS-style Command application shortcuts and menus |

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

Hyprland consumes these physical Command chords, represented by `ALT` in the
configuration, and sends Ctrl shortcuts to the focused
application:

| Physical shortcut | Delivered shortcut | Intended action |
| --- | --- | --- |
| Command+C | Ctrl+Insert | Copy |
| Command+V | Ctrl+V | Paste |
| Command+X | Ctrl+X | Cut |
| Command+A | Ctrl+A | Select all |
| Command+Z | Ctrl+Z | Undo |
| Command+Shift+Z | Ctrl+Shift+Z | Redo |
| Command+S | Ctrl+S | Save |
| Command+Shift+S | Ctrl+Shift+S | Save as |
| Command+F | Ctrl+F | Find |
| Command+W | Ctrl+W | Close tab or document |
| Command+Q | Ctrl+Q | Quit application where supported |
| Command+T | Ctrl+T | New tab |
| Command+N | Ctrl+N | New window |
| Command+L | Ctrl+L | Address or location bar |
| Command+left-click | Ctrl+left-click | Open link in a new tab |
| Command+R | Ctrl+R | Reload |
| Command+Shift+T | Ctrl+Shift+T | Reopen closed tab |
| Command+P | Ctrl+P | Print |
| Command+0 | Ctrl+0 | Reset zoom |
| Command+- | Ctrl+- | Zoom out |
| Command+= | Ctrl+= | Zoom in |

Command+Space opens Omarchy 4's main menu. Command+Return opens its apps menu.
The full Lua definitions live in `omarchy/hypr/bindings.lua`.

Command+Q follows the common Linux GUI convention of Ctrl+Q. Terminal programs
do not generally interpret Ctrl+Q as quit, so Caps+W remains the reliable
Omarchy shortcut for closing the active terminal window.

Copy uses Ctrl+Insert so physical Ctrl+C remains available for terminal
interrupts. The Ghostty overlay maps Ctrl+Insert to copy and maps the other
translated Ctrl shortcuts to Ghostty actions.

## Word navigation

The physical Option key emits Hyper/MOD3 and retains macOS-style word
navigation:

| Physical shortcut | Delivered shortcut | Action |
| --- | --- | --- |
| Option+Left | Ctrl+Left | Previous word |
| Option+Right | Ctrl+Right | Next word |
| Option+Shift+Left | Ctrl+Shift+Left | Select previous word |
| Option+Shift+Right | Ctrl+Shift+Right | Select next word |
| Option+Backspace | Ctrl+Backspace | Delete previous word |

These bindings are repeatable, so holding an arrow or Backspace continues the
operation. Ghostty maps the translated Ctrl+Backspace chord directly to the
Ctrl+W control byte used by Bash for deleting the previous word. This bypasses
Ghostty's separate Ctrl+W binding for closing a tab.

## Semantic workspaces

| Physical shortcut | Workspace | Monitor | Routed application |
| --- | --- | --- | --- |
| Option+1 | `1` Freeform | Dell | None |
| Option+2 | `2` Freeform | Dell | None |
| Option+B | `B` Browser | Dell | Google Chrome |
| Option+C | `C` Code | Dell | Cursor |
| Option+M | `M` Music | LG | Spotify |
| Option+N | `N` Notes | Dell | Obsidian |
| Option+P | `P` Personal | Dell | None |
| Option+S | `S` Slack | Dell | Slack |
| Option+T | `T` Terminal | LG | Ghostty |
| Option+W | `W` WhatsApp | LG | WhatsApp |

Option+Shift plus the same number or letter moves the active window silently
to that workspace. Option+Tab returns to the previously focused workspace.
This matches the physical AeroSpace workspace controls while leaving the
AeroSpace configuration unchanged.

The Dell is matched by `desc:Dell Inc. AW2725QF 51GD934`; the LG is matched by
`desc:LG Electronics LG ULTRAGEAR 308NTLE7U344`. All workspaces remain visible
when empty. New application windows move silently to their assigned workspace.

Caps Lock remains `SUPER`, so Omarchy's stock shortcuts are still available.
Examples include Caps+W to close a window, Caps+T to toggle floating/tiling,
Caps+S for the scratchpad, Caps+P for pseudo mode, Caps+C for universal copy,
and Caps+1 through Caps+0 for the stock numbered workspaces. The numbered
workspace shortcuts are useful secondary aliases alongside Option+1 and
Option+2.

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
