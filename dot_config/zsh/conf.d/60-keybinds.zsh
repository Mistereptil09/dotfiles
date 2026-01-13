# ─── Key Bindings ─────────────────────────────────────────────────────────────
if (( $+functions[history-substring-search-up] )); then
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi
