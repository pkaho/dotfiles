local wezterm = require('wezterm')
local nf = wezterm.nerdfonts

local M = {}

M.setup = function()
  wezterm.on('new-tab-button-click', function(window, pane, button, default_action)
    local showlauncher = wezterm.action.ShowLauncherArgs({
      title = nf.fa_rocket .. ' Select/Search:',
      flags = 'FUZZY|LAUNCH_MENU_ITEMS|DOMAINS',
    })

    if default_action and button == 'Left' then
      window:perform_action(default_action, pane)
    elseif default_action and button == 'Right' then
      window:perform_action(showlauncher, pane)
    end

    return false
  end)
end

return M
