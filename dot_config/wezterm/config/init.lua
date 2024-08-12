local wezterm = require("wezterm")
local color = require("config.colors").colors()
local window_frame = require("config.colors").window_frame()

local config = {
	exit_behavior = "CloseOnCleanExit",
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	animation_fps = 60,
	max_fps = 60,
	canonicalize_pasted_newlines = "CarriageReturnAndLineFeed",

	-- color scheme
	colors = color,

	-- tab bar
	use_fancy_tab_bar = true,
	window_frame = window_frame,

	-- font
	line_height = 1.2,
	font_size = 14,
	font = wezterm.font_with_fallback({
		{ family = "Monaspace Argon",    weight = "Regular" }, -- scoop install monaspace
		{ family = "FiraCode Nerd Font", weight = "Regular" }, -- scoop install firacode-nf
		{ family = "LXGW WenKai",        weight = "Regular" }, -- scoop install lxgwwenkai
	}),

	-- scrollbar
	enable_scroll_bar = true,

	-- window
	adjust_window_size_when_changing_font_size = false,
	window_decorations = "RESIZE", -- RESIZE、TITLE、NONE、INTEGRATED_BUTTONS
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 2,
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.55,
	},
}

return config
