local wezterm = require("wezterm")

local M = {}

local palette = {
	black = "#000000",
	coral = "#ff8f5f",
	fuchsia = "#df31fb",
	linen = "#ebe8db",

	tab_title_colors = {
		default = { fg = "#808080", bg = "#000000" }, -- gray
		hover = { fg = "#5d4c52", bg = "#000000" }, -- dimgray
		active = { fg = "#f06060", bg = "#000000" }, -- salmon
	},

	right_status_colors = {
		left = { fg = "#1e90ff", bg = "#000000" }, -- dodgerblue
		middle = { fg = "#ff4f81", bg = "#000000" }, -- deeppink
		right = { fg = "#ff8f5f", bg = "#000000" }, -- coral
		split = { fg = "#5d4a44", bg = "#000000" }, -- dimgray
	},
}

-- custom colorscheme
local catppucin_mocha = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
local rose_pine = require("config.colors.rose-pine").colors()

function M.palette()
	return palette
end

function M.window_frame()
	return {
		font = wezterm.font({ family = "FiraCode Nerd Font" }),
		font_size = 11,
		active_titlebar_bg = "#000000",
		inactive_titlebar_bg = "#000000",
	}
end

function M.colors()
	local colors = catppucin_mocha
	local colors = rose_pine

	-- custom colors
	-- colors.cursor_bg = 'orange'
	colors.cursor_bg = palette.coral
	colors.cursor_fg = palette.black
	colors.split = palette.coral
	colors.tab_bar.new_tab.fg_color = palette.coral
	colors.tab_bar.new_tab.bg_color = palette.black
	colors.tab_bar.new_tab_hover.fg_color = palette.linen
	colors.tab_bar.new_tab_hover.bg_color = palette.black
	colors.scrollbar_thumb = palette.fuchsia
	return colors
end

return M
