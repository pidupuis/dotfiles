# Install with: brew bundle --file ~/dotfiles/Brewfile

# --- Shell --------------------------------------------------------------------
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "fzf"            # fuzzy Ctrl-R history search

# --- Dev tools ----------------------------------------------------------------
brew "git"            # newer than Apple's
brew "gh"             # GitHub CLI
brew "jq"             # JSON (used by the `json` function)
brew "tree"           # used by the `tre` function
brew "bat"            # `cat` with syntax highlighting

# --- Apps ---------------------------------------------------------------------
# An app that is already in /Applications (e.g. installed by hand) is skipped:
# Homebrew can't take over a signed app without the terminal being granted
# "App Management" access, and these apps update themselves anyway.
def app(token, name)
  cask token unless File.exist?("/Applications/#{name}.app")
end

app "orbstack",           "OrbStack"
app "visual-studio-code", "Visual Studio Code"
app "google-chrome",      "Google Chrome"
app "claude",             "Claude"
app "proton-drive",       "Proton Drive"
app "signal",             "Signal"
app "whatsapp",           "WhatsApp"
app "discord",            "Discord"
app "steam",              "Steam"
