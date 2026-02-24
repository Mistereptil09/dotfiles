# ─── History Options ──────────────────────────────────────────────────────────
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicate entries
setopt HIST_FIND_NO_DUPS        # Don't show dupes when searching
setopt HIST_IGNORE_SPACE        # Don't save commands starting with space
setopt HIST_EXPIRE_DUPS_FIRST   # Expire dupes first when trimming
setopt HIST_VERIFY              # Show expanded history before executing
setopt INC_APPEND_HISTORY       # Add commands immediately
setopt SHARE_HISTORY            # Share history between sessions

# ─── Directory Options ────────────────────────────────────────────────────────
setopt AUTO_CD                  # cd by typing directory name
setopt AUTO_PUSHD               # Push dirs to stack automatically
setopt PUSHD_IGNORE_DUPS        # Don't push duplicates
setopt PUSHD_SILENT             # Don't print stack after pushd/popd

# ─── Correction & Globbing ────────────────────────────────────────────────────
setopt CORRECT                  # Command correction
setopt EXTENDED_GLOB            # Extended globbing
setopt NO_CASE_GLOB             # Case insensitive globbing

# ─── Comment Behavior ────────────────────────────────────────────────────
setopt INTERACTIVE_COMMENTS