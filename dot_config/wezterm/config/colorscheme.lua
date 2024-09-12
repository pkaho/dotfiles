local wezterm = require('wezterm')

-- refer: https://stackoverflow.com/questions/20154991/generating-uniform-random-numbers-in-lua
math.randomseed(os.time())
math.random()
math.random()
math.random()

local function scheme_for_appearance()
	local appearance = wezterm.gui and wezterm.gui.get_appearance() or 'Dark'
	local colorscheme = wezterm.plugin.require('https://github.com/neapsix/wezterm')
	if appearance == 'Dark' then
		return colorscheme.moon.colors()
	else
		return colorscheme.dawn.colors()
	end
end

local colors = scheme_for_appearance()
colors.cursor_fg = '#FFFFFF'
colors.cursor_bg = '#FEA90A'
colors.quick_select_label_bg = { AnsiColor = 'Navy' }
colors.quick_select_label_fg = { AnsiColor = 'Silver' }
colors.quick_select_match_bg = { AnsiColor = 'Olive' }
colors.quick_select_match_fg = { AnsiColor = 'Silver' }
colors.scrollbar_thumb = '#8000AA'
colors.tab_bar = {
	new_tab = {
		fg_color = '#F06060',
		bg_color = '#000000',
	},
	new_tab_hover = {
		fg_color = '#8A4C52',
		bg_color = '#000000',
	},
}

local frame = {
	font = wezterm.font({ family = 'FiraCode Nerd Font', weight = 'Bold' }),
	font_size = 11,
	active_titlebar_bg = '#000000',
	inactive_titlebar_bg = '#000000',
}

return {
	window_frame = frame,
	colors = colors,
}
