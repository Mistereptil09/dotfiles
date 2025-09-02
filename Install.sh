#!/bin/bash
set -e  # stop if any command fails

# Installing yadm
echo "📦 Installing yadm..."
if ! command -v yadm &> /dev/null; then
    sudo dnf install -y yadm
else
    echo "✅ yadm already installed"
fi

# Cloning repo
if [ ! -d "$HOME/.local/share/yadm/repo.git" ]; then
    echo "📂 Cloning repo..."
    yadm clone https://github.com/Mistereptil09/dotfiles.git
else
    echo "🔄 Repo already cloned, pulling latest..."
    yadm pull
fi

# Running bootstrap
if [ -x "$HOME/.config/yadm/bootstrap" ]; then
    echo "🚀 Running bootstrap script..."
    yadm bootstrap
else
    echo "⚠️  No bootstrap script found in ~/.config/yadm/bootstrap"
    echo "    Skipping bootstrap step."
fi
