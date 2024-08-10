# Change dirs
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias cd..="cd .."
alias d="dirs -v|head -10"
alias 1="cd -"
alias 2="cd -2"
alias 3="cd -3"
alias 4="cd -4"
alias 5="cd -5"
alias 6="~6"
alias 7="~7"
alias 8="~8"
alias 9="~9"


# Save copying
alias cp="cp -vi"
alias mv="mv -vi"
alias ln="ln -vi"

# Better copying
alias cpv="rsync -avh --info=progress2"

# More alias
alias bc="bc -l"
alias c="clear"
alias count="ls *|wc -l"
alias h="history"
alias j="jobs -l" # check background jobs, use fg <num> to frontground
alias mkdir="mkdir -pv"
alias path="echo -e ${PATH//:/\\n}"
alias nautilus="nautilus ."

# Get external ip, icanhazip = I can has ip
alias extip="curl icanhazip.com"

# Third party tools
alias lg="lazygit"
alias top="btop"
alias du="dust"
alias nv="nvim"
alias vim="nvim"
alias cat="bat"
alias df="duf"

# suffix alias
# For files with a specified suffix, edit the file using the file name
alias -s {lua,py,zsh}="nvim"

# Global alias, can be used anywhere on the command line
# example: ps -ef G <keyword>
alias -g G="|rg -i"

# eza
alias ls="eza"
alias l="eza -lh"
alias la="eza -a"
alias ld="eza -D"
alias lf="eza -f"
alias ll="eza -lh"
alias lr="eza -lrh"
alias ls="eza --no-quotes"
alias lt="eza -T"
alias lab="eza --absolute"
alias lla="eza -la"
alias lld="eza -lD"
alias llf="eza -lf"
