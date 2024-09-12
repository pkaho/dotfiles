local wezterm = require('wezterm')
local icons = require('utils.icons')
local nf = wezterm.nerdfonts

local __cells__ = {}

local _add_cell = function(fg, bg, text)
	table.insert(__cells__, { Foreground = { Color = fg } })
	table.insert(__cells__, { Background = { Color = bg } })
	table.insert(__cells__, { Attribute = { Intensity = 'Bold' } })
	table.insert(__cells__, { Text = text })
end

local function _set_title(tab_info, max_width)
	local title = tab_info:gsub('%.exe$', '')
	title = wezterm.truncate_right(title, max_width - 2)

	return title
end

local function get_battery_info()
  local battery_info = wezterm.battery_info()
  if #battery_info > 0 then
    local battery = battery_info[1]
    local idx = math.floor(battery.state_of_charge * 10)
    if battery.state == 'Charging' then
      return icons.charging[idx] .. ' ' .. string.format('%.0f%%', battery.state_of_charge * 100)
    else
      return icons.discharging[idx] .. ' ' .. string.format('%.0f%%', battery.state_of_charge * 100)
    end
  end
end

local function get_cwd(cwd_uri)
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
    return cwd:gsub('/C:/Users/.*/', '~/')
  end
  return ''
end

-- KeyTable notice
wezterm.on('update-right-status', function (window, pane)
  __cells__ = {}

  local name = window:active_key_table()
  if name then
    _add_cell('#FAB387', '#000000', icons.SEMI_CIRCLE_LEFT)
    _add_cell('#1C1B19', '#FAB387', icons.KEY_TABLE)
    _add_cell('#1C1B19', '#FAB387', ' '..string.upper(name))
    _add_cell('#FAB387', '#000000', icons.SEMI_CIRCLE_RIGHT)
  end

  if window:leader_is_active() then
    _add_cell('#FAB387', '#000000', icons.SEMI_CIRCLE_LEFT)
    _add_cell('#1C1B19', '#FAB387', icons.KEY)
    _add_cell('#1C1B19', '#FAB387', ' ')
    _add_cell('#FAB387', '#000000', icons.SEMI_CIRCLE_RIGHT)
  end

  window:set_left_status(wezterm.format(__cells__))
end)

-- TabTitle
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  __cells__ = {}
  local title = _set_title(tab.active_pane.title, max_width)
  local unseen_output = ' '
  local colors = { fg = '#808080', on = '#fffacd', bg = '#000000' }

  if tab.is_active then
    colors.fg = '#F06060'
  elseif hover then
    colors.fg = '#8A4C52'
  end

  for _, pane in ipairs(tab.panes) do
    if pane.has_unseen_output then
      unseen_output = ' ' .. icons.CIRCLE
      break
    end
  end

  local status_items = {
    { colors.fg, colors.bg, icons.SEMI_CIRCLE_LEFT },
    { colors.bg, colors.fg, ' ' .. title },
    { colors.on, colors.fg, unseen_output },
    { colors.fg, colors.bg, icons.SEMI_CIRCLE_RIGHT },
  }

  for _, item in ipairs(status_items) do
    _add_cell(item[1], item[2], item[3])
  end

  return __cells__
end)

-- New Button
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

-- RightStatus
wezterm.on('update-right-status', function(window, pane)
  -- status_cells = {}
  __cells__ = {}
  local battery_info = get_battery_info()
  -- local cwd = get_cwd(pane)
  local cwd = get_cwd(pane:get_current_working_dir())

  local status_items = {
    { '#1E90FF', '#000000', battery_info or cwd },
    { '#5D4A44', '#000000', ' ' .. icons.TRIANGLE_LEFT .. ' ' },
    { '#FF4F81', '#000000', icons.calendar .. ' ' .. wezterm.strftime('%a %b %d') },
    { '#5D4A44', '#000000', ' ' .. icons.TRIANGLE_LEFT .. ' ' },
    { '#FF8F5F', '#000000', icons.clock .. ' ' .. wezterm.strftime('%H:%M:%S') .. ' ' },
  }

  for _, item in ipairs(status_items) do
    _add_cell(item[1], item[2], item[3])
  end

  window:set_right_status(wezterm.format(__cells__))
end)
