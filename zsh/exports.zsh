# Default editor
export EDITOR="vim"
export VISUAL="$EDITOR"

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8"

# Don't clear the screen after quitting a manual page
export MANPAGER="less -X"
# Highlight section titles in manual pages (Solarized yellow)
export LESS_TERMCAP_md=$'\e[1;38;5;136m'
export LESS_TERMCAP_me=$'\e[0m'

# Colored `ls` (BSD ls on macOS), Solarized-friendly
export CLICOLOR=1
export LSCOLORS="ExGxFxdaCxDaDahbadacec"

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000
# Commands not worth remembering
export HISTORY_IGNORE="(ls|l|ll|cd|cd -|pwd|exit|date|history|clear|c)"
