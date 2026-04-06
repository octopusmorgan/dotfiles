#!/bin/bash

set -e

REPO_URL="${1:-https://github.com/octopusmorgan/dotfiles.git}"
SOURCE_DIR="${2:-$HOME/dotfiles}"

echo "=== Installing dotfiles from $REPO_URL ==="

# Install chezmoi if not present
if ! command -v chezmoi &> /dev/null; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsSL https://get.chezmoi.io)"
fi

# Clone or update repo
if [ -d "$SOURCE_DIR" ] && [ -d "$SOURCE_DIR/.git" ]; then
    echo "Updating $SOURCE_DIR..."
    cd "$SOURCE_DIR" && git pull
elif [ -d "$SOURCE_DIR" ]; then
    echo "Directory exists but is not a git repo. Removing..."
    rm -rf "$SOURCE_DIR"
    git clone "$REPO_URL" "$SOURCE_DIR"
else
    echo "Cloning repo..."
    git clone "$REPO_URL" "$SOURCE_DIR"
fi

# Initialize chezmoi
echo "Initializing chezmoi..."
mkdir -p ~/.local/share/chezmoi
chezmoi init --source "$SOURCE_DIR"

# Apply configuration
echo "Applying configuration..."
chezmoi apply

echo "=== Done! ==="
