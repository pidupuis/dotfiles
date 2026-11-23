# --- Navigation ---------------------------------------------------------------
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cd..="cd .."
alias -- -="cd -"

alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/Projects"

# --- ls (BSD ls on macOS; colors come from CLICOLOR/LSCOLORS) -----------------
alias l="ls -lFh"                                    # long format
alias ll="ls -laFh"                                  # long format incl. dot files
alias lsd="ls -lFh | grep --color=never '^d'"        # directories only

alias c="clear"

# Git: `g st`, `g cm "msg"`… (short aliases live in .gitconfig)
alias g="git"

# Safe delete: moves to the macOS Trash (built-in /usr/bin/trash), recoverable.
# `rm` itself is intentionally left untouched.
alias del="trash"

# --- Time & date --------------------------------------------------------------
alias week="date +%V"
alias timestamp="date +%s"
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# --- Misc ---------------------------------------------------------------------
# Intuitive map: `find . -name .gitattributes | map dirname`
alias map="xargs -n1"

# --- Network ------------------------------------------------------------------
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
