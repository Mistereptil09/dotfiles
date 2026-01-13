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

# System utilities
alias df='df -h'
alias du='du -h'
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
