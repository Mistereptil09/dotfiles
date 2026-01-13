#!/bin/bash
set -e  # exit on error

REPO_URL="https://github.com/Mistereptil09/dotfiles.git"

# Ensure common chezmoi installation locations are in PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Detect OS once
OS_NAME=$(. /etc/os-release && echo "$ID")

echo "📦 Installing essential packages..."
case "$OS_NAME" in
    fedora)
        echo "➡️ Installing zsh and dependencies on Fedora..."
        sudo dnf install -y zsh git curl
        ;;
    debian|ubuntu)
        echo "➡️ Installing zsh and dependencies on Debian/Ubuntu..."
        sudo apt-get update
        sudo apt-get install -y zsh git curl
        ;;
    arch|manjaro)
        echo "➡️ Installing zsh and dependencies on Arch..."
        sudo pacman -S --noconfirm zsh git curl
        ;;
    *)
        echo "⚠️  Unknown distribution ($OS_NAME)."
        echo "Please install zsh, git, and curl manually before continuing."
        echo "Then run this script again."
        exit 1
        ;;
esac

# Verify essential packages are installed
if ! command -v zsh &>/dev/null; then
    echo "❌ Error: zsh is not installed. Please install it manually."
    exit 1
fi

echo "📦 Checking for chezmoi..."
if ! command -v chezmoi &>/dev/null; then
    echo "➡️ Installing chezmoi..."
    
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
            # Install to $HOME/bin explicitly
            mkdir -p "$HOME/bin"
            sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/bin"
            ;;
    esac
else
    echo "✅ chezmoi already installed"
fi

# Verify chezmoi is now accessible
if ! command -v chezmoi &>/dev/null; then
    echo "❌ Error: chezmoi installation failed or not in PATH"
    echo "Please install chezmoi manually: https://www.chezmoi.io/install/"
    exit 1
fi

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
