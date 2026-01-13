# ─── FZF Configuration ─────────────────────────────────────────────────────────
# FZF fuzzy finder: load shell integration
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
fi

# ─── FZF Customization Options ─────────────────────────────────────────────────
export FZF_DEFAULT_OPTS="
  --border=thinblock
  --padding=0,2
  --info=inline-right
  --layout=reverse
  --height=50%
  --color=fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color=info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
"

# CTRL-R: fuzzy-search history with preview toggle
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window=up:3:hidden:wrap \
  --bind 'ctrl-/:toggle-preview' --color header:italic \
  --header 'Press CTRL-/ to toggle preview.'
"

# CTRL-T: fuzzy-find files & dirs with bat preview & skip except folder
export FZF_CTRL_T_COMMAND="fd --type f"
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

# ALT-C: fuzzy-cd using fd
export FZF_ALT_C_COMMAND="fd --type directory"
export FZF_ALT_C_OPTS="
  --preview 'eza -l --icons {}/ | head -20' --bind 'ctrl-/:toggle-preview'
"
