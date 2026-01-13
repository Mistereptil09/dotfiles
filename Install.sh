#!/bin/bash
set -e  # exit on error

REPO_URL="https://github.com/Mistereptil09/dotfiles.git"

echo "📦 Checking for chezmoi..."
if ! command -v chezmoi &>/dev/null; then
    echo "➡️ Installing chezmoi..."
    
    # Detect OS
    OS_NAME=$(. /etc/os-release && echo "$ID")
    
    case "$OS_NAME" in
        fedora)
            sudo dnf install -y chezmoi
            ;;
        debian|ubuntu)
            sudo apt-get update
            sudo apt-get install -y chezmoi
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm chezmoi
            ;;
        *)
            # Fallback to binary install
            echo "📥 Installing chezmoi binary..."
            sh -c "$(curl -fsLS get.chezmoi.io)"
            # Add chezmoi to PATH for this session
            export PATH="$HOME/bin:$PATH"
            ;;
    esac
else
    echo "✅ chezmoi already installed"
fi

# Ensure chezmoi is in PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

echo "📂 Setting up dotfiles with chezmoi..."
if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    chezmoi init "$REPO_URL"
    echo "🔄 Applying dotfiles..."
    chezmoi apply
else
    echo "🔄 Dotfiles already initialized, pulling latest..."
    chezmoi update
fi

echo "🎉 Installation complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal or log out and back in"
echo "  2. Set Zsh as your default shell: chsh -s \$(which zsh)"
echo "  3. Customize your setup by editing ~/.config/zsh/conf.d/99-local.zsh"
