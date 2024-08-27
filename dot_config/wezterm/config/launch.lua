local platform = require('utils.platform')

local options = {
  default_prog = {},
  launch_menu = {},
}

if platform.is_win then
  options.default_prog = { 'pwsh' }
  options.launch_menu = {
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
  options.default_prog = { 'zsh' }
  options.launch_menu = {
    { label = 'Bash', args = { 'bash' } },
    { label = 'Fish', args = { 'fish' } },
    { label = 'Zsh',  args = { 'zsh' } },
  }
elseif platform.is_mac then
  options.default_prog = { 'zsh' }
  options.launch_menu = {
    { label = 'Bash', args = { 'bash' } },
    { label = 'Fish', args = { 'fish' } },
    { label = 'Zsh',  args = { 'zsh' } },
  }
end

return options
