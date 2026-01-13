# Dotfiles

Personal dotfiles repository managed with [chezmoi](https://www.chezmoi.io/), featuring a modular Zsh configuration with Zinit plugin manager.

---

## 🖥️ Features

- **Modular Zsh Configuration** - Organized into `conf.d/` for easy customization
- **Zinit Plugin Manager** - Fast and efficient plugin loading with turbo mode
- **Starship Prompt** - Beautiful, customizable shell prompt
- **Multiple Terminal Configs**:
  - Kitty terminal (primary)
  - Ghostty terminal (alternative)
- **Chezmoi** - Dotfiles management with templating support

---

## Prerequisites
- Linux (Fedora, Debian/Ubuntu, or Arch)
- `curl` and `git` installed
- `sudo` access for package installation

---

## 🚀 Quick Install (One-liner)

Run this if you trust the script and want a fast setup:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Mistereptil09/dotfiles/main/Install.sh)
```

---

## 🛠 Manual Install (Download first)

If you want to inspect or edit the installer first:

```bash
curl -o Install.sh https://raw.githubusercontent.com/Mistereptil09/dotfiles/main/Install.sh
chmod +x Install.sh
./Install.sh
```

---

## 📁 Configuration Structure

### Modular Zsh Setup

The Zsh configuration is split into logical modules under `~/.config/zsh/conf.d/`:

```
~/.config/zsh/
├── .zshrc              # Minimal entry point that sources all conf.d/*.zsh files
└── conf.d/
    ├── 00-env.zsh      # Environment variables (EDITOR, HISTFILE, PATH)
    ├── 10-zinit.zsh    # Zinit plugin manager initialization
    ├── 20-plugins.zsh  # Plugin loading with Zinit turbo mode
    ├── 30-fzf.zsh      # FZF fuzzy finder configuration
    ├── 40-completion.zsh # Completion system and plugin settings
    ├── 50-aliases.zsh  # Command aliases (eza, bat, git, etc.)
    ├── 60-keybinds.zsh # Key bindings
    ├── 70-tools.zsh    # External tools (zoxide, starship, tmux)
    └── 99-local.zsh    # Machine-specific customizations
```

### Customization

Add your personal aliases, functions, or environment variables to `~/.config/zsh/conf.d/99-local.zsh`. This file is managed by chezmoi as a template and is intended for machine-specific settings that shouldn't be shared across all your systems.

### Tmux Auto-start

Tmux auto-start is optional and disabled by default. To enable it, set:

```bash
export DOTFILES_TMUX_AUTOSTART=1
```

Add this to your `99-local.zsh` or set it in your system environment.

---

## 🎨 Terminal Emulators

This repository includes configurations for:

- **Kitty** - Fast, feature-rich GPU-accelerated terminal
- **Ghostty** - Alternative modern terminal emulator

Both use the Tokyo Night color scheme for a consistent look.

---

## Post-Installation

1. Restart your terminal or log out and back in
2. Set Zsh as your default shell (if not already done):
   ```bash
   chsh -s $(which zsh)
   ```
3. Customize your setup:
   - Edit `~/.config/zsh/conf.d/99-local.zsh` for personal settings
   - Modify individual conf.d files to tweak specific aspects

---

## 🔄 Managing Your Dotfiles

With chezmoi, you can:

```bash
# Edit a file (opens in your EDITOR)
chezmoi edit ~/.config/zsh/.zshrc

# See what would change
chezmoi diff

# Apply changes from the repo
chezmoi apply

# Update from remote repository
chezmoi update

# Add a new file to be managed
chezmoi add ~/.config/newfile
```

For more information, see the [chezmoi documentation](https://www.chezmoi.io/).

---

## 📦 Included Tools & Plugins

### Zsh Plugins (via Zinit)
- zsh-completions - Additional completion definitions
- fzf-tab - Enhanced tab completion with fzf
- zsh-history-substring-search - Better history search
- zsh-autosuggestions - Fish-like autosuggestions
- zsh-you-should-use - Reminds you to use aliases
- zsh-syntax-highlighting - Command syntax highlighting

### Modern CLI Tools
- eza - Modern replacement for ls
- bat - Cat with syntax highlighting
- fzf - Fuzzy finder
- zoxide - Smart directory jumper
- starship - Cross-shell prompt
- tmux - Terminal multiplexer (optional auto-start)

---

## 🤝 Contributing

Feel free to fork this repository and adapt it to your needs. If you find improvements, pull requests are welcome!

---

## 📝 License

Feel free to use these dotfiles as inspiration for your own setup.
