-- ref: https://github.com/KevinSilvester/wezterm-config
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("events.guiStartup")
require("events.statusBar")

local function append(new_config)
	for k, v in pairs(new_config) do
		config[k] = v
	end
end

append(require("config.init"))
append(require("config.frontend"))
append(require("config.colorscheme"))
append(require("config.launch"))
append(require("config.keymaps"))
append(require("config.rules"))

return config
