local wezterm = require("wezterm")

-- x86_64-pc-windows-msvc   - Windows
-- x86_64-unknown-linux-gnu - Linux
-- x86_64-apple-darwin      - macOS(Intal)
-- aarch64-apple-darwin     - macOS(Apple Silicon)

local triple = wezterm.target_triple
local is_win = triple:match("windows")
local is_linux = triple:match("linux")
local is_mac = triple:match("apple")
local os_name = is_win or is_linux or is_mac or "unknown"

return {
	os = os_name,
	is_win = is_win,
	is_linux = is_linux,
	is_mac = is_mac,
}
