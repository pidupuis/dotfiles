# ~/.zshrc — symlinked from ~/dotfiles/.zshrc by install.sh
#
# Homebrew's environment ($HOMEBREW_PREFIX, PATH) is set in ~/.zprofile,
# which is machine-specific and not managed by this repo.

# Resolve the real location of this file (follows the symlink) → ~/dotfiles
export DOTFILES="${${(%):-%x}:A:h}"

# Personal binaries
path=("$HOME/bin" "$HOME/.local/bin" $path)
typeset -U path

for file in exports options prompt aliases functions plugins; do
	[[ -r "$DOTFILES/zsh/$file.zsh" ]] && source "$DOTFILES/zsh/$file.zsh"
done
unset file

# Machine-specific or private settings that must never be committed
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
