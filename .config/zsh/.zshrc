# ═══════════════════════════════════════════════════════════════════════════════
# ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    ███████╗███████╗██╗  ██╗
# ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    ╚══███╔╝██╔════╝██║  ██║
# ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║      ███╔╝ ███████╗███████║
# ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║     ███╔╝  ╚════██║██╔══██║
# ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ███████╗███████║██║  ██║
# ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚══════╝╚══════╝╚═╝  ╚═╝
# ═══════════════════════════════════════════════════════════════════════════════
# 
# ─── Environment Variables ────────────────────────────────────────────────────
export EDITOR=nano
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# ─── Path Extensions ──────────────────────────────────────────────────────────
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# ─── Antidote Plugin Manager ──────────────────────────────────────────────────
autoload -Uz compinit && compinit
source "$ZDOTDIR/.antidote/antidote.zsh"
antidote load "$ZDOTDIR/.zsh_plugins.txt"

# ─── External Tool Initialization ─────────────────────────────────────────────
# FZF fuzzy finder: load shell integration
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
  # Optional: disable unused key-binding
  # export FZF_ALT_C_COMMAND=
fi

# ─── fzf Customization Options ────────────────────────────────────────────────
export FZF_DEFAULT_OPTS="
  --border=thinblock
  --padding=0,2
  --info=inline-right
  --layout=reverse
  --height=50%
  --color=fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color=info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
"

# CTRL-R: fuzzy‑search history with preview toggle
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window=up:3:hidden:wrap \
  --bind 'ctrl-/:toggle-preview' --color header:italic \
  --header 'Press CTRL-/ to toggle preview.'
"

# CTRL-T: fuzzy‑find files & dirs with bat preview & skip except folder
export FZF_CTRL_T_COMMAND="fd --type f"
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

# ALT-C: fuzzy‑cd using fd
export FZF_ALT_C_COMMAND="fd --type directory"
export FZF_ALT_C_OPTS="
  --preview 'eza -l --icons {}/ | head -20' --bind 'ctrl-/:toggle-preview'
"

# ─── Zoxide smart directory jumper ─────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init --hook pwd zsh)"
fi

# ─── Starship prompt ───────────────────────────────────────────────────────────
eval "$(starship init zsh)"

# ─── Zsh Options ─────────────────────────────────────────────────────────────
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS INC_APPEND_HISTORY SHARE_HISTORY
setopt AUTO_CD CORRECT EXTENDED_GLOB

# ─── Completion System ────────────────────────────────────────────────────────
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ─── Plugin Configuration ─────────────────────────────────────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_YOU_SHOULD_USE_EXCLUDE=('ls' 'cd')
ZSH_YOU_SHOULD_USE_HOOKED_COMMANDS=('git')

# fzf‑tab Configuration
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

# ─── Aliases & Modern Commands ────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias ls='eza --icons'
  alias l='eza -lah --icons'
  alias ll='eza -l --icons'
  alias tree='eza --tree'
else
  alias l='ls -lah'
  alias ll='ls -l'
fi

if command -v bat &>/dev/null; then
  alias cat='bat'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias gs='git status'
alias gl='git log --oneline --graph'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'

alias df='df -h'
alias du='du -h'
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'

# ─── Key Bindings ─────────────────────────────────────────────────────────────
if (( $+functions[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# ─── Auto‑start Tmux ──────────────────────────────────────────────────────────
if command -v tmux &>/dev/null && [[ -z "$TMUX" ]] && [[ -z "$SSH_TTY" ]]; then
  tmux attach -t default || tmux new -s default
fi

# ─── Local Customizations ─────────────────────────────────────────────────────
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

