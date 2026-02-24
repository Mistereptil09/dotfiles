# ─── Plugin Loading with Zinit (Turbo Mode) ───────────────────────────────────

# Completions - load early, setup compinit after
zinit ice lucid wait'0a' blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# Initialize completion system after completions are loaded
zinit ice lucid wait'0a' atinit'zicompinit; zicdreplay'
zinit snippet OMZL::completion.zsh

# Enhanced navigation with fzf-tab (after compinit)
zinit ice lucid wait'0b'
zinit light Aloxaf/fzf-tab

# History search with multi-word support
zinit ice lucid wait'0c'
zinit light zdharma-continuum/history-search-multi-word

# Auto suggestions
zinit ice lucid wait'0d' atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# You should use - suggests aliases
zinit ice lucid wait'0e'
zinit light MichaelAquilina/zsh-you-should-use

# Sudo with double ESC
zinit ice lucid wait'0f'
zinit snippet OMZP::sudo

# Universal extract
zinit ice lucid wait'0g'
zinit snippet OMZP::extract

# Syntax highlighting (must be last)
zinit ice lucid wait'0h'
zinit light zdharma-continuum/fast-syntax-highlighting
