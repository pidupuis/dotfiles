#!/usr/bin/env bash
#
# Usage:
#   ./install.sh            symlink dotfiles into ~ (existing files are backed up)
#   ./install.sh --brew     … and install everything in the Brewfile
#   ./install.sh --macos    … and apply macOS preferences (.macos)
#   ./install.sh --all      all of the above
#
# Nothing is ever deleted: a file already in ~ is renamed to <name>.backup.<date>.

set -euo pipefail

# Never run the macOS installer inside a dev container (exit 0 so a misconfigured
# VS Code dotfiles step changes nothing and doesn't fail the container setup)
if [ -n "${REMOTE_CONTAINERS:-}" ] || [ -n "${CODESPACES:-}" ] || [ -f /.dockerenv ]; then
	echo "install.sh is for the Mac. In a container, use install-container.sh." >&2
	exit 0
fi

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

do_brew=false
do_macos=false
for arg in "$@"; do
	case "$arg" in
		--brew)  do_brew=true ;;
		--macos) do_macos=true ;;
		--all)   do_brew=true; do_macos=true ;;
		-h|--help) sed -n '3,9p' "$0"; exit 0 ;;
		*) echo "Unknown option: $arg" >&2; exit 1 ;;
	esac
done

# link <path in repo> [path under ~, defaults to the same]
link() {
	local src="$DOTFILES/$1" rel="${2:-$1}"
	local dst="$HOME/$rel"
	if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
		echo "  ok      ~/$rel"
		return
	fi
	mkdir -p "$(dirname "$dst")"
	if [ -e "$dst" ] || [ -L "$dst" ]; then
		mv "$dst" "$dst.backup.$STAMP"
		echo "  backup  ~/$rel → ~/$rel.backup.$STAMP"
	fi
	ln -s "$src" "$dst"
	echo "  linked  ~/$rel"
}

echo "Linking dotfiles from $DOTFILES"
for f in .zshrc .gitconfig .gitignore_global .hushlogin; do
	link "$f"
done
# Claude Code user settings (no Claude attribution on commits/PRs)
link claude/settings.json .claude/settings.json

# Git identity: kept out of the repo
if [ ! -f "$HOME/.gitconfig.local" ]; then
	echo
	echo "Git identity (stored in ~/.gitconfig.local, not committed)"
	read -r -p "  Name:  " git_name
	read -r -p "  Email (tip: <user>@users.noreply.github.com): " git_email
	cat > "$HOME/.gitconfig.local" <<EOF
[user]
	name = $git_name
	email = $git_email
EOF
	chmod 600 "$HOME/.gitconfig.local"
	echo "  created ~/.gitconfig.local"
fi

if $do_brew; then
	if ! command -v brew >/dev/null 2>&1; then
		echo "Homebrew is not installed. Install it from https://brew.sh first." >&2
		exit 1
	fi
	echo
	echo "Installing Brewfile…"
	brew bundle --file "$DOTFILES/Brewfile"
fi

if $do_macos; then
	echo
	echo "Applying macOS preferences…"
	bash "$DOTFILES/.macos"
fi

echo
echo "Done. Open a new terminal (or run: exec zsh)."
