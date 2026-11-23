# Dotfiles

My macOS setup: plain zsh (no framework) with a Solarized Dark prompt, git
config and aliases, a Brewfile and a few macOS preferences.

```
user at host in ~/dotfiles on master [+!?$]
$
```

## Install

1. Install [Homebrew](https://brew.sh).
2. Clone and run:

   ```zsh
   git clone git@github.com:pidupuis/dotfiles.git ~/dotfiles
   cd ~/dotfiles && ./install.sh --all
   ```

`install.sh` only creates symlinks; any existing file is renamed to
`<file>.backup.<date>`, never deleted. Flags: `--brew`, `--macos`, `--all`.

## Layout

| File | What it does |
|---|---|
| `.zshrc` | Entry point; loads `zsh/*.zsh`, then `~/.zshrc.local` if present |
| `zsh/prompt.zsh` | Solarized prompt with git status (`+` staged, `!` unstaged, `?` untracked, `$` stash) |
| `zsh/aliases.zsh` | Navigation, `ls`, time, network aliases |
| `zsh/functions.zsh` | `mkd`, `calc`, `fs`, `targz`, `tre`, `json`, `digga`, `getcertnames`, `server` |
| `zsh/options.zsh` | History, completion, key bindings |
| `zsh/plugins.zsh` | fzf, zsh-autosuggestions, zsh-syntax-highlighting (from Homebrew) |
| `.gitconfig` | Git aliases (`st`, `cm`, `aa`, `plr`, `go`, …) and settings |
| `.gitignore_global` | OS/editor noise only |
| `Brewfile` | CLI tools and apps |
| `.macos` | Typing, Finder, Dock, power/update preferences |
| `claude/settings.json` | Claude Code user settings → `~/.claude/settings.json` (no Claude attribution on commits/PRs) |

## Private / machine-specific settings

These are **not** in the repo and are never committed:

- `~/.gitconfig.local`: git `user.name` / `user.email` (created by `install.sh`)
- `~/.zshrc.local`: tokens, work-specific aliases, anything private
- `~/.zprofile`: Homebrew / OrbStack environment

## Credits

Originally forked from [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
(MIT); the prompt and several functions derive from his work. Some aliases come
from [Dries Vints' dotfiles](https://github.com/driesvints/dotfiles).
