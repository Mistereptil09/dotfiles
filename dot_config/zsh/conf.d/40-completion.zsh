# ─── Zsh Options ──────────────────────────────────────────────────────────────
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS INC_APPEND_HISTORY SHARE_HISTORY
setopt AUTO_CD CORRECT EXTENDED_GLOB

# ─── Completion System ─────────────────────────────────────────────────────────
autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ─── Plugin Configuration ──────────────────────────────────────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_YOU_SHOULD_USE_EXCLUDE=('ls' 'cd')
ZSH_YOU_SHOULD_USE_HOOKED_COMMANDS=('git')

# fzf-tab Configuration
zstyle ':fzf-tab:*' popup-min-size 50 8
zstyle ':fzf-tab:*' fzf-default-opts "${FZF_DEFAULT_OPTS}"

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:default:*' \
  fzf-preview 'bat --color=always $realpath 2>/dev/null' \
  fzf-preview-window 'right:40%'

zstyle ':fzf-tab:*' fzf-bindings 'ctrl-k:kill-line,ctrl-space:toggle+down'
zstyle ':completion:cd:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:git:*' matcher-list 'r:|[._-]=* r:|=*'
zstyle ':fzf-tab:group-colors' \
  directory  $'\e[32m' \
  executable $'\e[33m' \
  file       $'\e[37m' \
  symlink    $'\e[36m'
