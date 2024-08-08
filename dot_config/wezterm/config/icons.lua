local wezterm = require('wezterm')
local nf = wezterm.nerdfonts

-- refer: https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
local icons = {
  clock    = nf.md_clock,           -- 󰥔
  calendar = nf.md_calendar,        -- 󰃭

  discharging = {
    nf.md_battery_10, -- 󰁺
    nf.md_battery_20, -- 󰁻
    nf.md_battery_30, -- 󰁼
    nf.md_battery_40, -- 󰁽
    nf.md_battery_50, -- 󰁾
    nf.md_battery_60, -- 󰁿
    nf.md_battery_70, -- 󰂀
    nf.md_battery_80, -- 󰂁
    nf.md_battery_90, -- 󰂂
    nf.md_battery,    -- 󰁹
  },
  charging = {
    nf.md_battery_charging_10,  -- 󰢜
    nf.md_battery_charging_20,  -- 󰂆
    nf.md_battery_charging_30,  -- 󰂇
    nf.md_battery_charging_40,  -- 󰂈
    nf.md_battery_charging_50,  -- 󰢝
    nf.md_battery_charging_60,  -- 󰂉
    nf.md_battery_charging_70,  -- 󰢞
    nf.md_battery_charging_80,  -- 󰂊
    nf.md_battery_charging_90,  -- 󰂊
    nf.md_battery_charging_100, -- 󰂅
  },

  -- tab icons
  GLYPH_SEMI_CIRCLE_LEFT  = nf.ple_left_half_circle_thick,  -- 
  GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick, -- 
  GLYPH_LARGE_CIRCLE      = nf.cod_circle_large_filled,     -- 
  GLYPH_CIRCLE            = nf.md_record,                   -- 󰑊
  TRIANGLE_LEFT           = nf.cod_triangle_left,           -- 
}

return icons
