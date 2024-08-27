local wezterm = require("wezterm")

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
    return wezterm.plugin.require('https://github.com/neapsix/wezterm').moon.colors()
	else
	  return wezterm.plugin.require('https://github.com/neapsix/wezterm').dawn.colors()
	end
end
local colors = scheme_for_appearance(get_appearance())

colors.tab_bar = {
	new_tab = {
    fg_color = "#F06060",
		bg_color = "#000000",
	},
	new_tab_hover = {
    fg_color = "#8A4C52",
		bg_color = "#000000",
	},
}

colors.cursor_fg = "#FFFFFF"
colors.cursor_bg = "#F09000"
colors.quick_select_label_bg = { AnsiColor = "Navy" }
colors.quick_select_label_fg = { AnsiColor = "Silver" }
colors.quick_select_match_bg = { AnsiColor = "Olive" }
colors.quick_select_match_fg = { AnsiColor = "Silver" }

local frame = {
	font = wezterm.font({ family = "FiraCode Nerd Font", weight = "Bold" }),
	font_size = 11,
	active_titlebar_bg = "#000000",
	inactive_titlebar_bg = "#000000",
}

return {
	window_frame = frame,
	colors = colors,
}
