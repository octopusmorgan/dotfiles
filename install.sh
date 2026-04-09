#!/bin/bash

set -e

REPO_URL="${1:-https://github.com/octopusmorgan/dotfiles.git}"
SOURCE_DIR="${2:-$HOME/.dotfiles}"

echo "=== Installing dotfiles from $REPO_URL ==="

# Check requirements
check_requirement() {
    if ! command -v "$1" &> /dev/null; then
        echo "ERROR: $1 is required but not installed."
        echo "Please install $1 first."
        exit 1
    fi
}

echo "Checking requirements..."
check_requirement curl
check_requirement git
check_requirement zsh

# Install chezmoi if not present
if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$HOME/.local/bin"
fi

# Add chezmoi to PATH (installed to ~/.local/bin)
export PATH="$HOME/.local/bin:$PATH"

# Clone or update repo
if [ -d "$SOURCE_DIR" ] && [ -d "$SOURCE_DIR/.git" ]; then
    echo "Updating $SOURCE_DIR..."
    cd "$SOURCE_DIR" && git fetch origin && git reset --hard origin/master
elif [ -d "$SOURCE_DIR" ]; then
    echo "Directory exists but is not a git repo. Removing..."
    rm -rf "$SOURCE_DIR"
    git clone "$REPO_URL" "$SOURCE_DIR"
else
    echo "Cloning repo..."
    git clone "$REPO_URL" "$SOURCE_DIR"
fi

# Initialize chezmoi with symlink (simpler than chezmoi init)
echo "Initializing chezmoi..."
mkdir -p ~/.local/share
rm -rf ~/.local/share/chezmoi
ln -sf "$SOURCE_DIR" ~/.local/share/chezmoi

# Apply configuration (skip README which is just documentation)
echo "Applying configuration..."
chezmoi apply --force --exclude=README*

echo "=== Done! ==="
