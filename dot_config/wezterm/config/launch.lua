local platform = require('utils.platform')

local _prog
local _menu

if platform.is_win then
  _prog = { 'pwsh' }
  _menu = {
    { label = 'PowerShell Core',    args = { 'pwsh' } },
    { label = 'PowerShell Desktop', args = { 'powershell' } },
    { label = 'Command Prompt',     args = { 'cmd' } },
    { label = 'Nushell',            args = { 'nu' } },
    {
      label = 'Git Bash',
      args = { 'D:/Applications/Scoop/apps/git/current/bin/bash.exe' },
    },
    {
      label = 'WSL',
      args = { 'wsl' },
    },
  }
elseif platform.is_linux then
  _prog = { 'zsh' }
  _menu = {
    { label = 'Bash', args = { 'bash' } },
    { label = 'Fish', args = { 'fish' } },
    { label = 'Zsh',  args = { 'zsh' } },
  }
elseif platform.is_mac then
  _prog = { 'zsh' }
  _menu = {
    { label = 'Bash', args = { 'bash' } },
    { label = 'Fish', args = { 'fish' } },
    { label = 'Zsh',  args = { 'zsh' } },
  }
end

return {
  default_prog = _prog,
  launch_menu = _menu,
}
