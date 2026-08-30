-- Personal keybindings for Omarchy 4.

-- Load semantic workspace and application-routing rules. Omarchy's stock
-- hyprland.lua already loads this bindings file after all default rules.
require("hypr.workspaces")

local function send(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))
    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

-- Application overrides.
-- SUPER+SHIFT+B was Omarchy's regular browser binding.
hl.unbind("SUPER + SHIFT + B")
o.bind("SUPER + SHIFT + B", "Browser (private)", { omarchy = "browser --private" })

-- SUPER+SHIFT+W was Omarchy's Omawrite binding.
hl.unbind("SUPER + SHIFT + W")
o.bind("SUPER + SHIFT + W", "WhatsApp", { webapp = "https://web.whatsapp.com/" })

-- Keep the old physical menu shortcuts, using Omarchy 4's native menus.
o.bind("ALT + SPACE", "Omarchy menu", "omarchy-menu toggle root")
o.bind("ALT + RETURN", "Apps menu", "omarchy-menu toggle apps")

-- Semantic role workspaces (Caps Lock emits SUPER).
-- These unbind Omarchy actions before assigning the workspace shortcuts.
hl.unbind("SUPER + B")
hl.unbind("SUPER + C") -- Universal copy
hl.unbind("SUPER + M")
hl.unbind("SUPER + N")
hl.unbind("SUPER + P") -- Pseudo window
hl.unbind("SUPER + S") -- Scratchpad
hl.unbind("SUPER + T") -- Toggle floating/tiling
hl.unbind("SUPER + W") -- Close window

o.bind("SUPER + B", "Browser workspace", hl.dsp.focus({ workspace = "name:B" }))
o.bind("SUPER + C", "Cursor workspace", hl.dsp.focus({ workspace = "name:C" }))
o.bind("SUPER + M", "Music workspace", hl.dsp.focus({ workspace = "name:M" }))
o.bind("SUPER + N", "Notes workspace", hl.dsp.focus({ workspace = "name:N" }))
o.bind("SUPER + P", "Personal workspace", hl.dsp.focus({ workspace = "name:P" }))
o.bind("SUPER + S", "Slack workspace", hl.dsp.focus({ workspace = "name:S" }))
o.bind("SUPER + T", "Terminal workspace", hl.dsp.focus({ workspace = "name:T" }))
o.bind("SUPER + W", "WhatsApp workspace", hl.dsp.focus({ workspace = "name:W" }))

-- Preserve the window-management actions displaced above.
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())
o.bind("SUPER + SHIFT + T", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))

-- These replace Omarchy's Google Maps and Google Photos bindings.
hl.unbind("SUPER + SHIFT + S")
hl.unbind("SUPER + SHIFT + P")
o.bind("SUPER + SHIFT + S", "Toggle scratchpad", hl.dsp.workspace.toggle_special("scratchpad"))
o.bind("SUPER + SHIFT + P", "Pseudo window", hl.dsp.window.pseudo())

-- macOS-style application shortcuts. The physical Alt key beside Space acts
-- as Command and sends the corresponding Ctrl shortcut to the focused app.
o.bind("ALT + C", "macOS-style Copy", send("CTRL", "Insert"))
o.bind("ALT + V", "macOS-style Paste", send("CTRL", "V"))
o.bind("ALT + X", "macOS-style Cut", send("CTRL", "X"))
o.bind("ALT + A", "macOS-style Select all", send("CTRL", "A"))
o.bind("ALT + Z", "macOS-style Undo", send("CTRL", "Z"))
o.bind("ALT + SHIFT + Z", "macOS-style Redo", send("CTRL + SHIFT", "Z"))
o.bind("ALT + S", "macOS-style Save", send("CTRL", "S"))
o.bind("ALT + SHIFT + S", "macOS-style Save as", send("CTRL + SHIFT", "S"))
o.bind("ALT + F", "macOS-style Find", send("CTRL", "F"))
o.bind("ALT + W", "macOS-style Close tab or document", send("CTRL", "W"))
o.bind("ALT + T", "macOS-style New tab", send("CTRL", "T"))
o.bind("ALT + N", "macOS-style New window", send("CTRL", "N"))
o.bind("ALT + L", "macOS-style Address or location bar", send("CTRL", "L"))

-- Browser-oriented macOS-style shortcuts.
o.bind("ALT + mouse:272", "macOS-style Open link in new tab", send("CTRL", "mouse:272"), { mouse = true })
o.bind("ALT + R", "macOS-style Reload", send("CTRL", "R"))
o.bind("ALT + SHIFT + T", "macOS-style Reopen closed tab", send("CTRL + SHIFT", "T"))
o.bind("ALT + P", "macOS-style Print", send("CTRL", "P"))
o.bind("ALT + 0", "macOS-style Reset zoom", send("CTRL", "0"))
o.bind("ALT + minus", "macOS-style Zoom out", send("CTRL", "minus"))
o.bind("ALT + equal", "macOS-style Zoom in", send("CTRL", "equal"))

-- macOS-style Option navigation. The physical Windows key emits Hyper/MOD3.
o.bind("MOD3 + LEFT", "macOS-style Previous word", send("CTRL", "LEFT"), { repeating = true })
o.bind("MOD3 + RIGHT", "macOS-style Next word", send("CTRL", "RIGHT"), { repeating = true })
o.bind("MOD3 + SHIFT + LEFT", "macOS-style Select previous word", send("CTRL + SHIFT", "LEFT"), { repeating = true })
o.bind("MOD3 + SHIFT + RIGHT", "macOS-style Select next word", send("CTRL + SHIFT", "RIGHT"), { repeating = true })
o.bind("MOD3 + BACKSPACE", "macOS-style Delete previous word", send("CTRL", "BACKSPACE"), { repeating = true })
