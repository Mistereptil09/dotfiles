#!/bin/bash
set -e  # exit on error

REPO_URL="https://github.com/Mistereptil09/dotfiles.git"
BOOTSTRAP="$HOME/.config/yadm/bootstrap"

echo "📦 Checking for yadm..."
if ! command -v yadm &>/dev/null; then
    echo "➡️ Installing yadm..."
    if command -v dnf &>/dev/null; then
        TMPDIR=/tmp sudo dnf config-manager addrepo --from-repofile=https://download.opensuse.org/repositories/home:TheLocehiliosan:yadm/Fedora_42/home:TheLocehiliosan:yadm.repo
        sudo dnf install -y yadm
    else
        echo "❌ Package manager not supported. Please install yadm manually."
        exit 1
    fi
else
    echo "✅ yadm already installed"
fi

echo "📂 Setting up dotfiles..."
if [ ! -d "$HOME/.local/share/yadm/repo.git" ]; then
    yadm clone "$REPO_URL"
else
    echo "🔄 Repo already cloned, pulling latest..."
    yadm pull
fi

# Check OS before running bootstrap
OS_NAME=$(. /etc/os-release && echo "$ID")
if [ "$OS_NAME" != "fedora" ]; then
    echo "⚠️  Bootstrap is only supported on Fedora."
    echo "Skipping bootstrap run."
else
    if [ -f "$BOOTSTRAP" ]; then
        read -p "🚀 Do you want to run the bootstrap script now? (y/N): " RUN_BOOTSTRAP
        RUN_BOOTSTRAP=${RUN_BOOTSTRAP,,}  # convert to lowercase
        if [[ "$RUN_BOOTSTRAP" == "y" || "$RUN_BOOTSTRAP" == "yes" ]]; then
            chmod +x "$BOOTSTRAP"
            yadm bootstrap
            echo "✅ Bootstrap completed!"
        else
            echo "⚠️ Skipping bootstrap."
        fi
    else
        echo "⚠️ No bootstrap script found at $BOOTSTRAP"
    fi
fi

echo "🎉 Installation complete!"
