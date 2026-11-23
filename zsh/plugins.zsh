# Plugins installed with Homebrew (see Brewfile). Each one is optional: if it
# isn't installed, it is simply skipped.

_brew_share=${HOMEBREW_PREFIX:-/opt/homebrew}/share

# fzf: Ctrl-R fuzzy history, Ctrl-T fuzzy file picker, Alt-C fuzzy cd
(( $+commands[fzf] )) && source <(fzf --zsh)

# Grey inline suggestion from history; accept with →
[[ -r $_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] \
	&& source $_brew_share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Must be sourced last
[[ -r $_brew_share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
	&& source $_brew_share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

unset _brew_share
