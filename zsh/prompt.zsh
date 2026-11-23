# Solarized Dark prompt — zsh port of the original bash prompt
# (based on Mathias Bynens' / @necolas' prompt).
#
#   pierre at macbook in ~/dotfiles on master [+!?$]
#   $
#
# Git flags: + staged   ! unstaged   ? untracked   $ stashed
#
# Security note: git data (branch names can contain `$(…)`) is passed through
# $psvar and printed with %1v/%2v, so it is never re-evaluated by the shell.
# PROMPT_SUBST stays off on purpose.

autoload -Uz add-zsh-hook

# Solarized colors (256-color palette)
typeset -gA _sol=(
	orange 166  yellow 136  green 64  violet 61  blue 33  red 124  white 15
)

_prompt_git_info() {
	psvar[1]='' psvar[2]=''

	local out
	out=$(command git status --porcelain=v1 --branch 2>/dev/null) || return

	local -a lines=("${(@f)out}")
	local header=${lines[1]#\#\# } branch flags='' line

	case $header in
		'HEAD (no branch)'*)   branch=$(command git rev-parse --short HEAD 2>/dev/null) ;;
		'No commits yet on '*) branch=${header#No commits yet on } ;;
		'Initial commit on '*) branch=${header#Initial commit on } ;;
		*)                     branch=${${header%%...*}%% *} ;;
	esac

	local staged=0 unstaged=0 untracked=0
	for line in "${(@)lines[2,-1]}"; do
		if [[ $line == '??'* ]]; then
			untracked=1
		else
			[[ ${line[1]} != ' ' ]] && staged=1
			[[ ${line[2]} != ' ' ]] && unstaged=1
		fi
	done
	(( staged ))    && flags+='+'
	(( unstaged ))  && flags+='!'
	(( untracked )) && flags+='?'
	command git rev-parse --verify --quiet refs/stash >/dev/null 2>&1 && flags+='$'

	psvar[1]=$branch
	[[ -n $flags ]] && psvar[2]=" [$flags]"
}
add-zsh-hook precmd _prompt_git_info

# Set the terminal title to the current directory
_prompt_title() { print -Pn '\e]0;%~\a' }
add-zsh-hook precmd _prompt_title

# Username: red when root, orange otherwise.  Host: bold red over SSH.
if [[ -n $SSH_CONNECTION ]]; then
	_prompt_host="%F{${_sol[red]}}%m"
else
	_prompt_host="%F{${_sol[yellow]}}%m"
fi

PROMPT=$'\n'"%B%(!.%F{${_sol[red]}}.%F{${_sol[orange]}})%n"
PROMPT+="%F{${_sol[white]}} at ${_prompt_host}"
PROMPT+="%F{${_sol[white]}} in %F{${_sol[green]}}%~"
PROMPT+="%(1V.%F{${_sol[white]}} on %F{${_sol[violet]}}%1v%F{${_sol[blue]}}%2v.)"
PROMPT+=$'\n'"%F{${_sol[white]}}\$ %f%b"

PS2="%F{${_sol[yellow]}}→ %f"

unset _prompt_host
