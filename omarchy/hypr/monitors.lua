-- Personal monitor overrides for Omarchy 4.
-- Dell is the primary/right monitor; LG is the secondary/left monitor.

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = 2

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Fallback for any display not listed explicitly below.
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = omarchy_monitor_scale,
})

hl.monitor({
  output = "DP-2",
  mode = "3840x2160@144",
  position = "0x0",
  scale = omarchy_monitor_scale,
})

hl.monitor({
  output = "DP-1",
  mode = "3840x2160@164.99",
  position = "1920x0",
  scale = omarchy_monitor_scale,
})
