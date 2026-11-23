#!/usr/bin/env bash
#
# Container-only install, run by the VS Code Dev Containers "dotfiles" feature
# (set dotfiles.installCommand to "install-container.sh").
# Loads ONLY the zsh prompt theme and the aliases, and recreates the git
# identity file (~/.gitconfig.local) if it is missing.
#
# Deliberately does NOT call install.sh (which links .gitconfig / Claude
# settings, asks for a git identity, and can run the Brewfile and .macos).
#
# The image's own ~/.zshrc (oh-my-zsh, nvm...) is kept: we only add one block
# at the end, replaced in place if the script runs again.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC="$HOME/.zshrc"
BEGIN="# >>> dotfiles (container) >>>"
END="# <<< dotfiles (container) <<<"

touch "$ZSHRC"

# Drop a previous block of ours, if any (idempotent).
if grep -qF "$BEGIN" "$ZSHRC"; then
	tmp="$(mktemp)"
	awk -v b="$BEGIN" -v e="$END" '$0==b{skip=1} !skip{print} $0==e{skip=0}' "$ZSHRC" > "$tmp"
	cat "$tmp" > "$ZSHRC"
	rm -f "$tmp"
fi

cat >> "$ZSHRC" <<EOF
$BEGIN
source "$DOTFILES/zsh/prompt.zsh"
source "$DOTFILES/zsh/aliases.zsh"
# macOS-only aliases defined in aliases.zsh
unalias del localip ips 2>/dev/null || true
# Colors for GNU ls (CLICOLOR only works with the BSD ls of macOS)
alias ls='ls --color=auto'
$END
EOF

echo "install-container.sh: updated $ZSHRC (prompt + aliases only)"

# Git identity. VS Code copies ~/.gitconfig into the container, but not the
# ~/.gitconfig.local it includes, so commits have no author. Recreate it with
# the GitHub noreply identity (already public in every commit). Never
# overwrites an existing file or an identity configured another way.
GITLOCAL="$HOME/.gitconfig.local"
if command -v git >/dev/null 2>&1 && [ ! -e "$GITLOCAL" ] \
	&& ! (cd "$HOME" && git config --get user.email >/dev/null 2>&1); then
	git config --file "$GITLOCAL" user.name "Pierre Dupuis 井磊"
	git config --file "$GITLOCAL" user.email "pidupuis@users.noreply.github.com"
	chmod 600 "$GITLOCAL"
	echo "install-container.sh: created $GITLOCAL (noreply git identity)"
fi
