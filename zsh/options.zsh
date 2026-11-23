# --- Navigation ---------------------------------------------------------------
setopt AUTO_CD              # type a directory name to cd into it
setopt AUTO_PUSHD           # cd pushes onto the dir stack (`cd -<TAB>`)
setopt PUSHD_IGNORE_DUPS
setopt EXTENDED_GLOB        # **/*.txt, ^pattern, etc.
setopt NO_CASE_GLOB         # case-insensitive globbing
setopt INTERACTIVE_COMMENTS # allow `# comments` on the command line

# --- History ------------------------------------------------------------------
setopt EXTENDED_HISTORY     # save timestamps
setopt SHARE_HISTORY        # share history between open terminals
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE    # prefix a command with a space to keep it out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY          # `!!` expands for review instead of running immediately

# --- Completion ---------------------------------------------------------------
# Homebrew's completions (gh, git, …) must be on $fpath before compinit
[[ -n "$HOMEBREW_PREFIX" ]] && fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)

autoload -Uz compinit
compinit  # keeps the compaudit check for insecure completion dirs

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'  # case-insensitive, fuzzy on . _ -
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true

# --- Key bindings -------------------------------------------------------------
bindkey -e  # emacs-style line editing (Ctrl-A, Ctrl-E, …)

# Up/Down search history for commands starting with what's already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

# Option/Ctrl + ←/→ move by word, Home/End, Delete
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[b'     backward-word
bindkey '^[f'     forward-word
bindkey '^[[H'    beginning-of-line
bindkey '^[[F'    end-of-line
bindkey '^[[3~'   delete-char
