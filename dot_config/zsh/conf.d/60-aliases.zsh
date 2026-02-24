# ─── Aliases & Modern Commands ────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias eaz='eza --color=auto'
  alias ls='eza --icons'
  alias l='eza -lah --icons'
  alias ll='eza -l --icons'
  alias tree='eza --tree'
else
  alias l='ls -lah'
  alias ll='ls -l'
fi

# Utiliser batcat sur Ubuntu/Debian, bat ailleurs
if command -v batcat &>/dev/null; then
  alias bat='batcat'
  alias cat='batcat'
elif command -v bat &>/dev/null; then
  alias cat='bat'
fi

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases
alias gs='git status'
alias gl='git log --oneline --graph'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpl='git pull'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstp='git stash pop'
alias grh='git reset --hard'
alias grs='git reset --soft HEAD~1'

# System utilities
alias df='df -h'
alias du='du -h'
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'

# ─── Interactive zoxide with fzf ──────────────────────────────────────────────
zz() {
  local dir
  dir=$(zoxide query --list | fzf \
    --height=50% \
    --preview='eza -la --color=always {}' \
    --preview-window='right:50%' \
    --header='Select directory')
  [[ -n "$dir" ]] && cd "$dir"
}