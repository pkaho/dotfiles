Invoke-Expression (&starship init powershell)

Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function MenuComplete # press ^+d show completion

Invoke-Expression (& { (zoxide init powershell | Out-String) })

# 使用`&`可以引用脚本, 如果你想保持脚本的变量保持在当前脚本, 请使用`.`
. "$PSScriptRoot/functions.ps1"

Set-Alias ls eza
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias grep rg
Set-Alias nvide neovide
Set-Alias open explorer
Set-Alias lg lazygit
Set-Alias c clear

if ($host.Name -eq "ConsoleHost")
{
  Import-Module PSReadLine
  Set-PSReadLineOption -EditMode Emacs
  Set-PSReadLineOption -EditMode Vi
}

function crb  { Clear-RecycleBin -Force }
function Lock { rundll32.exe user32.dll, LockWorkStation }
function rm   { Remove-Item -Force -Recurse -Path $args }
function ckh  { Get-PSReadLineOption | rg HistorySavePath }

# starship config
Enable-TransientPrompt
function Invoke-Starship-TransientFunction {
  &starship module character
}
function Invoke-Starship-PreCommand {
    $host.ui.Write("🚀")
}
