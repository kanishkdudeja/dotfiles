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

-- Semantic role workspaces. The physical Option key emits Hyper/MOD3, leaving
-- Caps Lock/SUPER available for Omarchy's stock window-management shortcuts.
local semantic_workspaces = {
  { key = "B", name = "name:B", label = "Browser" },
  { key = "C", name = "name:C", label = "Code" },
  { key = "M", name = "name:M", label = "Music" },
  { key = "N", name = "name:N", label = "Notes" },
  { key = "P", name = "name:P", label = "Personal" },
  { key = "S", name = "name:S", label = "Slack" },
  { key = "T", name = "name:T", label = "Terminal" },
  { key = "W", name = "name:W", label = "WhatsApp" },
}

for _, workspace in ipairs(semantic_workspaces) do
  o.bind("MOD3 + " .. workspace.key, workspace.label .. " workspace", hl.dsp.focus({ workspace = workspace.name }))
  o.bind(
    "MOD3 + SHIFT + " .. workspace.key,
    "Move window to " .. workspace.label .. " workspace",
    hl.dsp.window.move({ workspace = workspace.name, follow = false })
  )
end

for workspace = 1, 2 do
  local key = "code:" .. tostring(workspace + 9)
  local name = tostring(workspace)
  o.bind("MOD3 + " .. key, "Freeform workspace " .. name, hl.dsp.focus({ workspace = name }))
  o.bind(
    "MOD3 + SHIFT + " .. key,
    "Move window to freeform workspace " .. name,
    hl.dsp.window.move({ workspace = name, follow = false })
  )
end

o.bind("MOD3 + TAB", "Former workspace", hl.dsp.focus({ workspace = "previous" }))

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
