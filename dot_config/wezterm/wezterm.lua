-- ref: https://github.com/KevinSilvester/wezterm-config
local wezterm = require('wezterm')
local config = wezterm.config_builder()

require('events.tab-title').setup()
require('events.new-tab-button').setup()
require('events.right-status').setup()
require('events.gui-startup').setup()
require('events.format-window-title').setup()

local function append(new_config)
  for k, v in pairs(new_config) do
    config[k] = v
  end
end

append(require('config.general'))
append(require('config.launch'))
append(require('config.keymaps'))
append(require('config.rules'))

return config
