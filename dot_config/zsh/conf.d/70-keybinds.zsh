# ─── Key Bindings ─────────────────────────────────────────────────────────────
# Note: history-search-multi-word uses Ctrl+R by default (no manual bindings needed)

# Emacs-style bindings (default)
bindkey -e

# ─── Home/End keys ──────────────────────────────────────────────────
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# ─── Word navigation ──────────────────────────────────────────────────
bindkey '^[[1;5C' forward-word   # Ctrl+Right
bindkey '^[[1;5D' backward-word  # Ctrl+Left

# Edit command in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# ─── Zoxide fzf widget (Ctrl+G) ───────────────────────────────────────────────
fzf-zoxide-widget() {
  local dir
  dir=$(zoxide query --list | fzf \
    --height=40% \
    --reverse \
    --preview='eza -1 --color=always {}')
  if [[ -n "$dir" ]]; then
    BUFFER="cd ${(q)dir}"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N fzf-zoxide-widget
bindkey '^G' fzf-zoxide-widget

# ─── Clipboard history widget (Ctrl+Y) ────────────────────────────────────────
fzf-clipboard-widget() {
    ch
    zle reset-prompt
}
zle -N fzf-clipboard-widget
bindkey '^Y' fzf-clipboard-widget
