local wezterm = require('wezterm')
local icons = require('config.icons')
local palette = require('config.colors').palette()

local __cells__ = {}

local _push = function(fg, bg, text)
  table.insert(__cells__, { Foreground = { Color = fg } })
  table.insert(__cells__, { Background = { Color = bg } })
  table.insert(__cells__, { Attribute = { Intensity = 'Bold' } })
  table.insert(__cells__, { Text = text })
end

local _set_title = function(tab_info, max_width)
  local title = tab_info:gsub('%.exe$', '')
  title = wezterm.truncate_right(title, max_width - 2)

  return title
end

local M = {}

M.setup = function()
  wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    __cells__ = {}
    local title = _set_title(tab.active_pane.title, max_width)
    local unseen_output = ''
    local tab_title_colors = palette.tab_title_colors
    local colors

    if tab.is_active then
      colors = tab_title_colors.active
    elseif hover then
      colors = tab_title_colors.hover
    else
      colors = tab_title_colors.default
    end

    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        unseen_output = ' ' .. icons.GLYPH_CIRCLE
        break
      end
    end

    local statusItems = {
      { colors.fg,     colors.bg, icons.GLYPH_SEMI_CIRCLE_LEFT },
      { colors.bg,     colors.fg, ' ' .. title },
      { palette.linen, colors.fg, unseen_output },
      { colors.bg,     colors.fg, ' ' },
      { colors.fg,     colors.bg, icons.GLYPH_SEMI_CIRCLE_RIGHT },
    }

    for _, item in ipairs(statusItems) do
      _push(item[1], item[2], item[3])
    end

    return __cells__
  end)
end

return M
