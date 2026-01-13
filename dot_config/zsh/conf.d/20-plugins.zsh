# ─── Plugin Loading with Zinit (Turbo Mode) ───────────────────────────────────
# Core completions
zinit ice lucid wait'0a' atload'zicompinit; zicdreplay'
zinit light zsh-users/zsh-completions

# Enhanced navigation with fzf-tab
zinit ice lucid wait'0b'
zinit light Aloxaf/fzf-tab

# History substring search
zinit ice lucid wait'0c'
zinit light zsh-users/zsh-history-substring-search

# Auto suggestions
zinit ice lucid wait'0d' atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# You should use
zinit ice lucid wait'0e'
zinit light MichaelAquilina/zsh-you-should-use

# Syntax highlighting (must be last)
zinit ice lucid wait'0f'
zinit light zsh-users/zsh-syntax-highlighting
