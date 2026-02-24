# ─── Completion System ─────────────────────────────────────────────────────────
# Note: compinit is called by zinit in 20-plugins.zsh via zicompinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' group-name ''

# ─── Plugin Configuration ──────────────────────────────────────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_YOU_SHOULD_USE_EXCLUDE=('ls' 'cd')

# ─── fzf-tab Configuration ─────────────────────────────────────────────────────
zstyle ':fzf-tab:*' popup-min-size 50 8
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# Preview for files
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  '([[ -f $realpath ]] && '"${BAT_CMD}"' --color=always --style=numbers $realpath) || \
   ([[ -d $realpath ]] && eza -1 --color=always $realpath) || \
   echo $realpath'

# git-specific previews
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'git log --oneline --graph --color=always $word 2>/dev/null | head -20'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
  'git show --color=always $word 2>/dev/null | head -50'
zstyle ':fzf-tab:complete:git-diff:*' fzf-preview \
  'git diff --color=always $word 2>/dev/null | head -50'

zstyle ':fzf-tab:*' fzf-bindings 'ctrl-space:toggle+down'
zstyle ':fzf-tab:*' switch-group '<' '>'

# ─── Zoxide completion ────────────────────────────────────────────────────────
_zoxide_z_complete() {
  local completions
  completions=$(zoxide query --list 2>/dev/null)
  if [[ -n "$completions" ]]; then
    compadd -M 'm:{a-z}={A-Za-z}' -V zoxide ${(f)completions}
  fi
}

# fzf-tab preview for zoxide
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:zi:*' fzf-preview 'eza -1 --color=always $realpath'