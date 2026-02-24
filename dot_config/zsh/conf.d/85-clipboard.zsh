# ─── Clipboard History (Wayland) ──────────────────────────────────────────────
# Uses cliphist + fzf for terminal-based clipboard management

# Only run on Wayland sessions
[[ -z "$WAYLAND_DISPLAY" ]] && return

# Check dependencies
if ! command -v cliphist &>/dev/null; then
  # Silent return - don't spam errors if not installed
  return
fi

# ─── Start clipboard watcher (if not already running) ─────────────────────────
if ! pgrep -f "wl-paste.*cliphist" &>/dev/null; then
  wl-paste --type text --watch cliphist store &!
  wl-paste --type image --watch cliphist store &!
fi

# ─── Clipboard history viewer ─────────────────────────────────────────────────
ch() {
  local selected
  selected=$(cliphist list | fzf \
    --height=50% \
    --preview='echo {} | cliphist decode' \
    --preview-window='right:40%:wrap' \
    --header='↵ copy │ ctrl-d delete │ ctrl-r refresh' \
    --bind='ctrl-d:execute-silent(echo {} | cliphist decode | cliphist delete-query)+reload(cliphist list)' \
    --bind='ctrl-r:reload(cliphist list)')

  [[ -n "$selected" ]] && echo "$selected" | cliphist decode | wl-copy
}

# ─── Quick aliases ────────────────────────────────────────────────────────────
alias c='wl-copy'
alias v='wl-paste'
alias cs='wl-copy --trim-newline'      # Copy without trailing newline
alias cv='cliphist list | head -1 | cliphist decode | wl-paste'  # Paste previous

# ─── Clear clipboard history ──────────────────────────────────────────────────
clip-clear() {
  cliphist wipe
  echo "Clipboard history cleared"
}

# ─── Copy file contents ───────────────────────────────────────────────────────
cf() {
  [[ -f "$1" ]] && wl-copy < "$1" || echo "File not found: $1"
}