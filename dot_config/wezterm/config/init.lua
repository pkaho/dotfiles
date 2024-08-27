local wezterm = require("wezterm")
local device = require("utils.gpuAdapter")

local config = {
  animation_fps = 60,
  max_fps = 60,
  front_end = "WebGpu",
  webgpu_preferred_adapter = device,

  -- window startup size
  initial_cols = 80, -- window width
  initial_rows = 24, -- window height

  -- tab bar
  use_fancy_tab_bar = true,

  -- font
  font_size = 14,
  line_height = 1.2,
  font = wezterm.font_with_fallback({
    { family = "Monaspace Argon",    weight = "Regular" }, -- scoop install monaspace
    { family = "FiraCode Nerd Font", weight = "Regular" }, -- scoop install firacode-nf
    { family = "LXGW WenKai",        weight = "Regular" }, -- scoop install lxgwwenkai
  }),

  -- scrollbar
  enable_scroll_bar = false,
  scrollback_lines = 3500,

  -- window
  adjust_window_size_when_changing_font_size = false,
  window_decorations = "RESIZE", -- RESIZE、TITLE、NONE、INTEGRATED_BUTTONS
  window_close_confirmation = "NeverPrompt",
  window_padding = {
    left   = 5,
    right  = 5,
    top    = 5,
    bottom = 0,
  },
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.55,
  },
}

return config
