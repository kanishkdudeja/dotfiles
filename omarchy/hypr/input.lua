-- Personal input overrides for Omarchy 4.

hl.config({
  cursor = {
    -- Work around cursor lag and sudden acceleration seen with the Intel B580.
    no_hardware_cursors = 1,
  },

  input = {
    -- Caps Lock drives Omarchy's Super shortcuts. The physical Windows key is
    -- a separate Hyper/MOD3 layer for macOS-style Option navigation.
    kb_options = "caps:super,altwin:hyper_win",

    repeat_rate = 40,
    repeat_delay = 600,
    sensitivity = 0,
    accel_profile = "flat",

    touchpad = {
      scroll_factor = 0.4,
    },
  },
})
