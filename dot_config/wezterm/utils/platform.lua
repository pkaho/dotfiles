local wezterm = require('wezterm')

-- x86_64-pc-windows-msvc   - Windows
-- x86_64-unknown-linux-gnu - Linux
-- x86_64-apple-darwin      - macOS(Intal)
-- aarch64-apple-darwin     - macOS(Apple Silicon)

local target = wezterm.target_triple
local platform = {
  is_win   = string.find(target, 'windows') ~= nil,
  is_linux = string.find(target, 'linux') ~= nil,
  is_mac   = string.find(target, 'apple') ~= nil,
}

return platform
