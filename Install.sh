#!/bin/bash
set -e  # exit on error

REPO_URL="https://github.com/Mistereptil09/dotfiles.git"

# Ensure common chezmoi installation locations are in PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Detect OS and package manager
OS_NAME=$(. /etc/os-release && echo "$ID")
OS_ID_LIKE=$(. /etc/os-release && echo "${ID_LIKE:-}")

# Function to detect package manager
detect_package_manager() {
    if command -v apt-get &>/dev/null; then
        echo "apt"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v pacman &>/dev/null; then
        echo "pacman"
    else
        echo "unknown"
    fi
}

echo "📦 Installing essential packages..."

# Try to match known distros first, then fall back to ID_LIKE, then detect package manager
INSTALL_METHOD=""
case "$OS_NAME" in
    fedora|rhel|centos)
        INSTALL_METHOD="dnf"
        ;;
    debian|ubuntu|pop|linuxmint|elementary|zorin)
        INSTALL_METHOD="apt"
        ;;
    arch|manjaro|endeavouros)
        INSTALL_METHOD="pacman"
        ;;
    *)
        # Check ID_LIKE for derivative distros
        if [[ "$OS_ID_LIKE" == *"debian"* ]] || [[ "$OS_ID_LIKE" == *"ubuntu"* ]]; then
            INSTALL_METHOD="apt"
        elif [[ "$OS_ID_LIKE" == *"fedora"* ]] || [[ "$OS_ID_LIKE" == *"rhel"* ]]; then
            INSTALL_METHOD="dnf"
        elif [[ "$OS_ID_LIKE" == *"arch"* ]]; then
            INSTALL_METHOD="pacman"
        else
            # Final fallback: detect package manager
            DETECTED_PM=$(detect_package_manager)
            if [[ "$DETECTED_PM" != "unknown" ]]; then
                INSTALL_METHOD="$DETECTED_PM"
                echo "⚠️  Unknown distribution ($OS_NAME), but detected $DETECTED_PM package manager."
            fi
        fi
        ;;
esac

# Install packages based on detected method
case "$INSTALL_METHOD" in
    dnf)
        echo "➡️ Installing zsh and dependencies using dnf..."
        sudo dnf install -y zsh git curl
        ;;
    apt)
        echo "➡️ Installing zsh and dependencies using apt..."
        sudo apt-get update
        sudo apt-get install -y zsh git curl
        ;;
    pacman)
        echo "➡️ Installing zsh and dependencies using pacman..."
        sudo pacman -S --noconfirm zsh git curl
        ;;
    *)
        echo "⚠️  Could not detect a supported package manager."
        echo "Distribution: $OS_NAME"
        if [[ -n "$OS_ID_LIKE" ]]; then
            echo "Based on: $OS_ID_LIKE"
        fi
        echo ""
        echo "Please install the following packages manually:"
        echo "  - zsh"
        echo "  - git"
        echo "  - curl"
        echo ""
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
    
    case "$INSTALL_METHOD" in
        dnf)
            sudo dnf install -y chezmoi
            ;;
        apt)
            sudo apt-get update
            sudo apt-get install -y chezmoi
            ;;
        pacman)
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
