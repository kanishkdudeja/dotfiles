# Omarchy macOS-style keybindings

This document records the keyboard changes made on 2026-08-09 to reproduce the most common macOS shortcuts on Omarchy without relying on Toshy.

The setup was tested with a NuPhy Air75 v3 in Windows mode, Omarchy 3.8.4, Hyprland 0.56.0, and Ghostty 1.3.1. The active configuration lives under `~/.config`; nothing under Omarchy's managed `~/.local/share/omarchy` directory was modified.

## Keyboard model

The physical modifiers have three separate roles:

| Physical key | Hyprland modifier | Purpose |
| --- | --- | --- |
| Caps Lock | `SUPER` | Omarchy shortcuts and window management |
| Windows key | `MOD3`/Hyper | macOS-style Option navigation |
| Alt beside Space | `ALT` | macOS-style Command application shortcuts |

This intentionally means that the Windows key is not Super. Caps Lock is the only convenient key used for Omarchy's Super shortcuts.

The Alt key remains Alt at the XKB level. Hyprland intercepts selected Alt chords and Alt+click, then sends the corresponding Linux Ctrl input to the focused application.

## Hyprland input change

File: `~/.config/hypr/input.conf`

Caps Lock was already mapped to Super. The Windows-to-Hyper option was added while preserving that mapping:

```ini
input {
  # Caps drives Omarchy's Super shortcuts; Windows keys are a private Option-style layer.
  kb_options = caps:super,altwin:hyper_win
}
```

The previous value was:

```ini
kb_options = caps:super
```

## Hyprland application shortcuts

File: `~/.config/hypr/bindings.conf`

These bindings use the physical Alt key in the Command-key position and deliver a Ctrl shortcut to the active window:

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
| Alt+left-click | Ctrl+left-click | Open a link in a new tab |
| Alt+R | Ctrl+R | Reload |
| Alt+Shift+T | Ctrl+Shift+T | Reopen closed tab |
| Alt+P | Ctrl+P | Print |
| Alt+0 | Ctrl+0 | Reset zoom |
| Alt+- | Ctrl+- | Zoom out |
| Alt+= | Ctrl+= | Zoom in |

The exact configuration block is:

```ini
# macOS-style application shortcuts (physical Alt key beside Space acts as Command)
bindd = ALT, C, macOS-style Copy, sendshortcut, CTRL, INSERT, activewindow
bindd = ALT, V, macOS-style Paste, sendshortcut, CTRL, V, activewindow
bindd = ALT, X, macOS-style Cut, sendshortcut, CTRL, X, activewindow
bindd = ALT, A, macOS-style Select all, sendshortcut, CTRL, A, activewindow
bindd = ALT, Z, macOS-style Undo, sendshortcut, CTRL, Z, activewindow
bindd = ALT SHIFT, Z, macOS-style Redo, sendshortcut, CTRL SHIFT, Z, activewindow
bindd = ALT, S, macOS-style Save, sendshortcut, CTRL, S, activewindow
bindd = ALT SHIFT, S, macOS-style Save as, sendshortcut, CTRL SHIFT, S, activewindow
bindd = ALT, F, macOS-style Find, sendshortcut, CTRL, F, activewindow
bindd = ALT, W, macOS-style Close tab or document, sendshortcut, CTRL, W, activewindow
bindd = ALT, T, macOS-style New tab, sendshortcut, CTRL, T, activewindow
bindd = ALT, N, macOS-style New window, sendshortcut, CTRL, N, activewindow
bindd = ALT, L, macOS-style Address or location bar, sendshortcut, CTRL, L, activewindow

# Browser-oriented macOS-style shortcuts
bindd = ALT, mouse:272, macOS-style Open link in new tab, sendshortcut, CTRL, mouse:272, activewindow
bindd = ALT, R, macOS-style Reload, sendshortcut, CTRL, R, activewindow
bindd = ALT SHIFT, T, macOS-style Reopen closed tab, sendshortcut, CTRL SHIFT, T, activewindow
bindd = ALT, P, macOS-style Print, sendshortcut, CTRL, P, activewindow
bindd = ALT, 0, macOS-style Reset zoom, sendshortcut, CTRL, 0, activewindow
bindd = ALT, minus, macOS-style Zoom out, sendshortcut, CTRL, minus, activewindow
bindd = ALT, equal, macOS-style Zoom in, sendshortcut, CTRL, equal, activewindow
```

`mouse:272` is Hyprland's left mouse button code. Translating Alt+left-click to Ctrl+left-click provides the conventional browser action for opening a link in a new tab. It applies globally, but only applications that assign meaning to Ctrl+click will react specially.

Copy originally delivered Ctrl+C. It was changed to Ctrl+Insert so copying in Ghostty does not replace Ctrl+C's terminal-interrupt behavior. Omarchy uses the same Ctrl+Insert convention for its stock universal-copy binding. Most Linux desktop applications support it, although an application with custom keyboard handling may still require physical Ctrl+C.

The existing Alt+Space application launcher and Alt+Return Omarchy menu bindings predated this work and are not part of the macOS compatibility block.

## Word navigation

The Windows key is converted to Hyper/MOD3 and acts like the macOS Option key for navigation:

| Physical shortcut | Delivered shortcut | Action |
| --- | --- | --- |
| Windows+Left | Ctrl+Left | Previous word |
| Windows+Right | Ctrl+Right | Next word |
| Windows+Shift+Left | Ctrl+Shift+Left | Select previous word |
| Windows+Shift+Right | Ctrl+Shift+Right | Select next word |
| Windows+Backspace | Ctrl+Backspace | Delete previous word |

The bindings are repeatable so holding an arrow or Backspace continues moving or deleting:

```ini
# macOS-style Option navigation (physical Windows key emits Hyper/MOD3)
binded = MOD3, LEFT, macOS-style Previous word, sendshortcut, CTRL, LEFT, activewindow
binded = MOD3, RIGHT, macOS-style Next word, sendshortcut, CTRL, RIGHT, activewindow
binded = MOD3 SHIFT, LEFT, macOS-style Select previous word, sendshortcut, CTRL SHIFT, LEFT, activewindow
binded = MOD3 SHIFT, RIGHT, macOS-style Select next word, sendshortcut, CTRL SHIFT, RIGHT, activewindow
binded = MOD3, BACKSPACE, macOS-style Delete previous word, sendshortcut, CTRL, BACKSPACE, activewindow
```

Alt+Arrow was considered for this layer but not adopted because Alt is already the Command-position application modifier.

## Semantic workspaces

Files:

- `~/.config/hypr/workspaces.conf`
- `~/.config/hypr/bindings.conf`
- `~/.config/hypr/hyprland.conf`
- `~/.config/waybar/config.jsonc`

Caps Lock emits Super and selects semantic workspaces inspired by the AeroSpace configuration:

| Physical shortcut | Workspace | Monitor | Routed application |
| --- | --- | --- | --- |
| Caps+1 | `1` Freeform | DELL | None |
| Caps+2 | `2` Freeform | DELL | None |
| Caps+B | `B` Browser | DELL | Google Chrome |
| Caps+C | `C` Cursor | DELL | Cursor |
| Caps+M | `M` Music | LG | Spotify |
| Caps+N | `N` Notes | DELL | Obsidian |
| Caps+P | `P` Personal | DELL | None |
| Caps+S | `S` Slack | DELL | Slack |
| Caps+T | `T` Terminal | LG | Ghostty |
| Caps+W | `W` WhatsApp | LG | WhatsApp web app or native app |

The DELL display is matched by `desc:Dell Inc. AW2725QF 51GD934`; the LG display is matched by `desc:LG Electronics LG ULTRAGEAR 308NTLE7U344`. Workspace `1` is the default on DELL and workspace `T` is the default on LG. All ten workspaces are persistent, including when empty.

New application windows are moved silently to their assigned workspace, so opening an application does not switch the focused workspace. Selecting an empty workspace does not automatically launch its application.

Waybar displays each workspace's actual Hyprland name using `"format": "{name}"`. The stock synthetic `1` through `5` persistent placeholders were removed, because Hyprland already keeps the semantic workspaces persistent. The DELL bar therefore shows `1 2 B C N P S`, while the LG bar shows `M T W`.

The user workspace file is sourced after the standard bindings:

```ini
source = ~/.config/hypr/workspaces.conf
```

The semantic workspace bindings are:

```ini
bindd = SUPER, B, Browser workspace, workspace, name:B
bindd = SUPER, C, Cursor workspace, workspace, name:C
bindd = SUPER, M, Music workspace, workspace, name:M
bindd = SUPER, N, Notes workspace, workspace, name:N
bindd = SUPER, P, Personal workspace, workspace, name:P
bindd = SUPER, S, Slack workspace, workspace, name:S
bindd = SUPER, T, Terminal workspace, workspace, name:T
bindd = SUPER, W, WhatsApp workspace, workspace, name:W
```

Caps+1 and Caps+2 retain Omarchy's existing numeric workspace bindings. Their workspace rules pin both to DELL.

The workspace bindings replace several Omarchy actions. Those window-management actions were preserved on new shortcuts:

| Physical shortcut | Action |
| --- | --- |
| Caps+Q | Close the active window |
| Caps+Shift+T | Toggle floating/tiling |
| Caps+Shift+S | Toggle the scratchpad |
| Caps+Shift+P | Toggle pseudo-tiling |
| Caps+Ctrl+T | Open Activity/btop using the existing Omarchy binding |

Caps+C no longer invokes Omarchy's universal-copy binding. Copy remains available through Command-position+C, which Hyprland sends as Ctrl+Insert.

## Ghostty behavior

File: `~/.config/ghostty/config`

Hyprland consumes the Alt chord and sends a Ctrl chord, so Ghostty binds the translated Ctrl shortcuts directly:

```ini
keybind = shift+insert=paste_from_clipboard
keybind = control+insert=copy_to_clipboard

# Hyprland maps the physical Command-position key (Alt) to these Ctrl chords.
# Ctrl+C remains unbound here so it continues to interrupt terminal processes.
keybind = control+v=paste_from_clipboard
keybind = control+a=select_all
keybind = control+f=start_search
keybind = control+w=close_tab:this
keybind = control+t=new_tab
keybind = control+n=new_window
```

Ctrl+Insert and Shift+Insert already existed in the Ghostty configuration. The six direct Ctrl action bindings were added. Hyprland's Alt+C mapping was then changed to Ctrl+Insert.

This deliberately changes the corresponding physical Ctrl shortcuts inside Ghostty:

| Physical Ctrl shortcut | Ghostty action | Shell behavior replaced |
| --- | --- | --- |
| Ctrl+V | Paste | Quoted insert |
| Ctrl+A | Select all | Move to beginning of line |
| Ctrl+F | Search scrollback | Move forward one character |
| Ctrl+W | Close tab | Delete previous word |
| Ctrl+T | New tab | Transpose characters |
| Ctrl+N | New window | Next history entry |

Physical Ctrl+C remains unbound by Ghostty and therefore continues to interrupt the foreground process. Command-position+C reaches Ghostty as Ctrl+Insert and copies instead.

Other translated shortcuts retain terminal semantics because Ghostty does not override them:

- Command-position+Z sends Ctrl+Z and suspends the foreground process rather than providing application-level undo.
- Command-position+L sends Ctrl+L and clears/redraws the terminal.
- Command-position+R sends Ctrl+R and starts shell history search.
- Command-position+P sends Ctrl+P and moves through shell history.
- Command-position+X sends Ctrl+X, which is commonly a shell/readline prefix.
- Command-position+S sends Ctrl+S, which may pause terminal output when software flow control is enabled.

## Toshy status

These changes were designed to cover the common shortcuts that previously motivated Toshy, but no Toshy package, service, autostart entry, or configuration was removed or disabled during this work. Its runtime status should be checked separately before considering the migration complete.

## Validation

Hyprland was reloaded and reported no configuration errors:

```sh
Hyprland --verify-config --config ~/.config/hypr/hyprland.conf
hyprctl reload
hyprctl configerrors
```

Ghostty accepted the configuration and was restarted through Omarchy:

```sh
ghostty +validate-config
omarchy restart terminal
```

## Dotfiles migration notes

The repository preserves byte-identical snapshots of every active regular file from `~/.config/hypr` and `~/.config/waybar` under `omarchy/hypr` and `omarchy/waybar`. Timestamped backup files are excluded. These snapshots are currently reference copies rather than automatically installed configuration.

Before activating the repository configuration:

1. The Ghostty shortcut block documented above is now in `ghostty/config-linux`. Reconcile the remaining live Ghostty settings before replacing or symlinking the active config.
2. Decide whether the remaining Omarchy-specific Ghostty settings belong in `config-linux` or in a separate included file.
3. After reinstalling Omarchy, compare its current user templates with the preserved Hyprland and Waybar snapshots before restoring them, so newer Omarchy settings are not discarded accidentally.
4. If an installer is added later, keep it Linux/Omarchy-only, operate only on user-owned files under `~/.config`, and never modify `~/.local/share/omarchy`.
5. Reconcile the clone path: `ghostty/install.sh` currently links from `~/dotfiles`, while this checkout is at `~/kd/dotfiles`.
6. After symlinking or copying configuration, validate the result and run each installer twice to confirm it is idempotent.

The active `~/.config/ghostty`, `~/.config/hypr`, and `~/.config/waybar` files remain regular files rather than links into this repository.
