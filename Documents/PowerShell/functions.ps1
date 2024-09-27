# <<<<<<<<<<<< Change dir <<<<<<<<<<<<
function l    { eza -1 }
function la   { eza -a }
function ld   { eza -D }
function lf   { eza -f }
function ll   { eza -l -h }
function lr   { eza -l -r -h }
function ls   { eza --no-quotes }
function lab  { eza --absolute }
function tree { eza -T }

function cd.. { cd .. }
function ..   { cd .. }
function ...  { cd ../.. }
# >>>>>>>>>>>> Change dir >>>>>>>>>>>>

# komorebic start/stop
function kst { komorebic start }
function ksp { komorebic stop }

# >>>>>>>>>>>> nvim >>>>>>>>>>>>
function cvim {
  nvim --clean -u $HOME/AppData/Local/nvim/mini-init.lua $args
}

# Quickly open the specified configuration file
function fvim {
  $original_path = $PWD.Path

  $paths = @{
    "c" = "$HOME/AppData/Local/nvim/"
    "w" = "$HOME/.config/wezterm/"
    "a" = "$HOME/AppData/Roaming/alacritty/"
  }
  $path = $paths[$args] -join "" # System.Object[] --> System.String
  # Write-Output "Variable type: $($path.GetType().FullName)"
  if (-not $path){
    $path = $original_path
  }

  Set-Location -Path $path
  # Write-Host "Press Enter to continue"
  # Read-Host
  $selected_file = $(fzf)
  if ([string]::IsNullOrWhiteSpace($selected_file)) {
    Set-Location -Path $original_path
    return
  }
  nvim $selected_file
}
# <<<<<<<<<<<< nvim <<<<<<<<<<<<

# >>>>>>>>>>>> wezterm >>>>>>>>>>>>
# wezterm imgcat
function imgcat {
  wezterm imgcat $args
}

# wezterm Shell Integration
# refer: https://wezfurlong.org/wezterm/shell-integration.html
# 主要用于 set_right_status 获取主机用户名使用
# refer: https://wezfurlong.org/wezterm/config/lua/window/set_right_status.html?h=set_right
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}
# <<<<<<<<<<<< wezterm <<<<<<<<<<<<

# ability to change the current working directory when exiting Yazi
function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -Path $cwd
    }
    Remove-Item -Path $tmp
}

# scoop
function i   { scoop install $args }
function u   { scoop update $args }
function s   { scoop search $args }
function x   { scoop uninstall $args }
function sca { scoop cache rm $args }
function scl { scoop cleanup -k * }
function sli { scoop list }
function sst { scoop status }

# chezmoi
function ccd { cd $(chezmoi source-path) }
