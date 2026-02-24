# ─── Environment Variables ────────────────────────────────────────────────────
export EDITOR=nano
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=20000
export SAVEHIST=20000

# ─── Clipboard settings ───────────────────────────────────────────────────────
export CLIPHIST_MAX_ITEMS=500

# ─── Path Extensions ──────────────────────────────────────────────────────────
export PATH="$HOME/.fzf/bin:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# ─── fd/fdfind compatibility ──────────────────────────────────────────────────
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  export FD_CMD="fdfind"
else
  export FD_CMD="fd"
fi

# ─── bat/batcat compatibility ─────────────────────────────────────────────────
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  export BAT_CMD="batcat"
else
  export BAT_CMD="bat"
fi