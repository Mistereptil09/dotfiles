# ─── Zoxide smart directory jumper ────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init --hook pwd zsh)"
fi

# ─── Starship prompt ───────────────────────────────────────────────────────────
eval "$(starship init zsh)"

# ─── Auto‑start Tmux (Optional) ────────────────────────────────────────────────
if [[ "${DOTFILES_TMUX_AUTOSTART:-0}" == "1" ]] && command -v tmux &>/dev/null && [[ -z "$TMUX" ]] && [[ -z "$SSH_TTY" ]]; then
  tmux attach -t default || tmux new -s default
fi
