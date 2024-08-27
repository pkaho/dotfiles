local wezterm = require("wezterm")
local act = wezterm.action
local io = require("io")
local os = require("os")

-- 暂时不做任何处理
local workspaces_list = {}
local text_choices = {}

-- ref: https://wezfurlong.org/wezterm/config/lua/wezterm/on.html#example-opening-whole-scrollback-in-vim
wezterm.on("trigger-vim-with-scrollback", function(window, pane)
	local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

	local name = os.tmpname()
	local f = io.open(name, "w+")
	f:write(text)
	f:flush()
	f:close()

	window:perform_action(
		act.SpawnCommandInNewWindow({
			args = { "nvim", name },
		}),
		pane
	)

	wezterm.sleep_ms(1000)
	os.remove(name)
end)

-- toggle un/maximize
wezterm.on("maximize", function(window)
	window:maximize()
end)
wezterm.on("normal", function(window)
	window:restore()
end)

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.win32_system_backdrop = "Auto" -- Auto, Disable, Acrylic, Mica, Tabbed
		overrides.window_background_opacity = 0.5
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

-- `wezterm show-keys --lua` View all current shortcut keys in the terminal
return {
	leader = { key = ",", mods = "ALT", timeout_milliseconds = 3000 },
	keys = {
		-- -------------------------------------------------------------------------- --
		--                                   General                                  --
		-- -------------------------------------------------------------------------- --
		{ key = "F1", mods = "NONE", action = act.ActivateCommandPalette },
		{ key = "F2", mods = "NONE", action = act.ActivateCopyMode },
		{ key = "F3", mods = "NONE", action = act.ShowLauncher },
		{ key = "F4", mods = "NONE", action = act.ShowLauncherArgs({ flags = "FUZZY|TABS" }) },
		{ key = "F5", mods = "NONE", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
		{ key = "F12", mods = "NONE", action = act.ShowDebugOverlay },
		{ key = "f", mods = "ALT", action = act.Search({ CaseInSensitiveString = "" }) },
		{ key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },
		{ key = "x", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
		{ key = "e", mods = "CTRL|SHIFT", action = act.EmitEvent("trigger-vim-with-scrollback") },
		{ key = "b", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-opacity") },
		{ key = "r", mods = "ALT", action = act.ReloadConfiguration },
		-- copy emoji
		{
			key = "u",
			mods = "CTRL|SHIFT",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},

		-- window status
		{ key = "b", mods = "ALT", action = act.Hide },
		{ key = "n", mods = "ALT", action = act.EmitEvent("normal") },
		{ key = "m", mods = "ALT", action = act.EmitEvent("maximize") },

		-- -------------------------------------------------------------------------- --
		--                                     Tab                                    --
		-- -------------------------------------------------------------------------- --
		{ key = "[", mods = "CTRL|ALT", action = act.MoveTabRelative(-1) },
		{ key = "]", mods = "CTRL|ALT", action = act.MoveTabRelative(1) },
		{ key = "[", mods = "ALT", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "ALT", action = act.ActivateTabRelative(1) },
		{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
		{
			key = "n",
			mods = "CTRL|ALT",
			action = wezterm.action_callback(function(win, pane)
				local tab, window = pane:move_to_new_tab()
			end),
		},

		-- -------------------------------------------------------------------------- --
		--                                    Pane                                    --
		-- -------------------------------------------------------------------------- --
		{ key = "z", mods = "ALT", action = act.TogglePaneZoomState },
		{ key = "w", mods = "ALT", action = act.CloseCurrentPane({ confirm = false }) },
		-- move between panes
		{ key = "j", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Up") },
		{ key = "h", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CTRL|ALT", action = act.ActivatePaneDirection("Right") },
		-- resize pane
		{ key = "LeftArrow",  mods = "ALT", action = act.AdjustPaneSize({ "Left",  1 }) },
		{ key = "RightArrow", mods = "ALT", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "UpArrow",    mods = "ALT", action = act.AdjustPaneSize({ "Up",    1 }) },
		{ key = "DownArrow",  mods = "ALT", action = act.AdjustPaneSize({ "Down",  1 }) },
		-- select pane
		{
			key = "p",
			mods = "ALT",
			action = act.PaneSelect({ alphabet = "123456789", mode = "Activate" }),
		},
		-- move the pane to the current position
		{
			key = "p",
			mods = "CTRL|ALT",
			action = act.PaneSelect({ alphabet = "123456789", mode = "SwapWithActive" }),
		},
		-- split pane
		{
			key = [[\]], -- another way to write: key = '\\'
			mods = "ALT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "ALT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},

		-- -------------------------------------------------------------------------- --
		--                               QuickSelectArgs                              --
		-- -------------------------------------------------------------------------- --
		-- need disable micsoft input method shortcut `Ctrl+space`
		{ key = " ", mods = "CTRL|SHIFT", action = act.QuickSelect },
		-- quickly select hash value
		{
			key = "h",
			mods = "CTRL|SHIFT|ALT",
			action = act.QuickSelectArgs({ patterns = { "[a-f0-9]{6,}" } }),
		},
		-- Alt+e open url like kitty(ctrl+e)
		-- the url must be displayed in full
		-- refer: https://github.com/wez/wezterm/issues/1362
		{
			key = "e",
			mods = "ALT",
			action = act.QuickSelectArgs({
				label = "open url",
				patterns = {
					"https?://\\S+",
				},
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.log_info("opening: " .. url)
					wezterm.open_with(url)
				end),
			}),
		},

		-- -------------------------------------------------------------------------- --
		--                                InputSelector                               --
		-- -------------------------------------------------------------------------- --
		-- ref: https://wezfurlong.org/wezterm/config/lua/keyassignment/InputSelector.html?h=input#example-of-switching-between-a-list-of-workspaces-with-the-inputselector
		{
			key = "s",
			mods = "CTRL|SHIFT",
			action = wezterm.action_callback(function(window, pane)
				local workspaces = workspaces_list

				window:perform_action(
					act.InputSelector({
						action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
							label = "Workspace: " .. label
							inner_window:perform_action(
								act.SwitchToWorkspace({
									name = label,
									spawn = { label = label, cwd = id },
								}),
								inner_pane
							)
						end),
						title = "Choose Workspace",
						choices = workspaces,
						fuzzy = true,
						fuzzy_description = "Fuzzy find and/or make a workspace: ",
					}),
					pane
				)
			end),
		},
    -- ref: https://wezfurlong.org/wezterm/config/lua/keyassignment/InputSelector.html?h=choices#example-of-choosing-some-canned-text-to-enter-into-the-terminal
		{
			key = "r",
			mods = "CTRL|SHIFT",
			action = act.InputSelector({
				action = wezterm.action_callback(function(window, pane, id, label)
					if not id and not label then
						wezterm.log_info("cancelled")
					else
						wezterm.log_info("you selected ", id, label)
						pane:send_text(id)
					end
				end),
				title = "Choose Text",
				choices = text_choices,
			}),
		},
    {
      key = 'f',
      mods = 'LEADER',
      action = act.ActivateKeyTable({
        name = 'resize_font',
        one_shot = false,
        timeout_miliseconds = 1000,
      })
    }
	},

	mouse_bindings = {
    -- Open Link
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},
		-- Left click to select copy, right click to paste
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = act.CompleteSelection("PrimarySelection"),
		},
		{
			event = { Up = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = act.PasteFrom("Clipboard"),
		},
		-- Easy Window Dragging(like KDE)
		{
			event = { Drag = { streak = 1, button = "Left" } },
			mods = "ALT",
			action = wezterm.action.StartWindowDrag,
		},
    -- Scrolling up/down while holding CTRL increases/decreases the font size
    {
      event = { Down = { streak = 1, button = { WheelUp = 1} } },
      mods = "CTRL",
      action = act.IncreaseFontSize,
    },
    {
      event = { Down = { streak = 1, button = { WheelDown = 1} } },
      mods = "CTRL",
      action = act.DecreaseFontSize,
    },
	},

	key_tables = {
		resize_font = {
			{ key = "k", action = act.IncreaseFontSize },
			{ key = "j", action = act.DecreaseFontSize },
			{ key = "r", action = act.ResetFontSize },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "q", action = "PopKeyTable" },
		},
		resize_pane = {
			{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "q", action = "PopKeyTable" },
		},
	},
}
