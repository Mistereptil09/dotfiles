# Dotfiles

Personal dotfiles repository for Fedora, including Zsh, Kitty, and yadm bootstrap setup.

---

## 🖥️ Features

- Zsh configuration with plugins
- Starship prompt
- Kitty terminal config
- `yadm` bootstrap script for Fedora

---
## Prerequisites
- Fedora Linux
- `curl` and `git` installed
- `sudo` access for package installation

---
## 🚀 Quick Install (One-liner)

Run this if you trust the script and want a fast setup:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Mistereptil09/dotfiles/Install.sh)
```

---
## 🛠 Manual Install (Download first)
if you want to inspect or edit the installer first :
```bash
curl -o Install.sh https://raw.githubusercontent.com/Mistereptil09/dotfiles/Install.sh
chmod +x Install.sh
./Install.sh
```
And you can find the scripts here :
[Install.sh](Install.sh)
[Boostrap](.config/yadm/bootstrap)

---
## Notes
- The bootstrap script automates package installation and symlinking for **Fedora only**.
- On other distros, you’ll need to install dependencies manually, even if you have the files.
- After installation, restart your terminal or log out and back in.

---
## Post-Installation
- Restart your terminal or log out and back in.
- Set Zsh as your default shell if not already done (should have been done by the bootstrap script):
```bash
  chsh -s \$(which zsh)
```
