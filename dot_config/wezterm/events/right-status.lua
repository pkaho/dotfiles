local wezterm = require('wezterm')
local icons = require('config.icons')
local palette = require('config.colors').palette().right_status_colors

local __cells__ = {}

local _push = function(color, text)
  table.insert(__cells__, { Foreground = { Color = color.fg } })
  table.insert(__cells__, { Background = { Color = color.bg } })
  table.insert(__cells__, { Attribute = { Intensity = 'Bold' } })
  table.insert(__cells__, { Text = text })
end

local M = {}

M.setup = function()
  wezterm.on('update-right-status', function(window, pane)
    __cells__ = {}

    local b_icon
    local battery

    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then
      local cwd = ''

      if type(cwd_uri) == 'userdata' then
        cwd = cwd_uri.file_path
      else
        cwd_uri = cwd_uri:sub(8)
        local slash = cwd_uri:find '/'
        if slash then
          cwd = cwd_uri:sub(slash):gsub('%%(%x%x)', function(hex)
            return string.char(tonumber(hex, 16))
          end)
        end
      end

      for _, b in ipairs(wezterm.battery_info()) do
        local idx = math.floor(b.state_of_charge * 10)
        if b.state == 'Charging' then
          b_icon = icons.charging[idx]
        else
          b_icon = icons.discharging[idx]
        end
        battery = string.format('%s %.0f%%', b_icon, b.state_of_charge * 100)
      end
      cwd = cwd:gsub('/C:/Users/.*/', '~/')

      _push(palette.left, battery or cwd)
      _push(palette.split, ' ' .. icons.TRIANGLE_LEFT .. ' ')
    end

    local statusItems = {
      { palette.middle, icons.calendar .. ' ' .. wezterm.strftime('%a %b %d') }, -- %Y-%m-%d
      { palette.split,  ' ' .. icons.TRIANGLE_LEFT .. ' ' },
      { palette.right,  icons.clock .. ' ' .. wezterm.strftime('%H:%M:%S') .. ' ' },
    }

    for _, item in ipairs(statusItems) do
      _push(item[1], item[2])
    end

    window:set_right_status(wezterm.format(__cells__))
  end)
end

return M
