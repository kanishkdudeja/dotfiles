-- Semantic workspaces inspired by the AeroSpace setup.

local dell = "desc:Dell Inc. AW2725QF 51GD934"
local lg = "desc:LG Electronics LG ULTRAGEAR 308NTLE7U344"

local function workspace(name, monitor, default)
  hl.workspace_rule({
    workspace = name,
    monitor = monitor,
    default = default or false,
    persistent = true,
  })
end

-- Dell: freeform, browser, code, notes, personal, and Slack.
workspace("1", dell, true)
workspace("2", dell)
workspace("name:B", dell)
workspace("name:C", dell)
workspace("name:N", dell)
workspace("name:P", dell)
workspace("name:S", dell)

-- LG: music, terminal, and WhatsApp.
workspace("name:M", lg)
workspace("name:T", lg, true)
workspace("name:W", lg)

-- Route newly opened application windows without changing the focused
-- workspace. Hyprland's current Lua window-rule syntax accepts " silent" on
-- the workspace effect.
o.window("(google-chrome|Google-chrome)", { workspace = "name:B silent" })
o.window("(Cursor|cursor)", { workspace = "name:C silent" })
o.window("(Spotify|spotify)", { workspace = "name:M silent" })
o.window("(Obsidian|obsidian)", { workspace = "name:N silent" })
o.window("(Slack|slack)", { workspace = "name:S silent" })
o.window("com.mitchellh.ghostty", { workspace = "name:T silent" })
o.window("(WhatsApp|chrome-web.whatsapp.com__.*)", { workspace = "name:W silent" })
