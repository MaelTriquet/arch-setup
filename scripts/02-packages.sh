#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> Installing packages..."

PACMAN_DIR="$REPO_DIR/packages/pacman"
YAY_DIR="$REPO_DIR/packages/yay"

# --- Pacman packages ---
if [ -d "$PACMAN_DIR" ]; then
    PACMAN_PACKAGES=$(cat "$PACMAN_DIR"/packages_*.txt 2>/dev/null | grep -v '^\s*#' | grep -v '^\s*$' | tr '\n' ' ')
    if [ -n "$PACMAN_PACKAGES" ]; then
        echo "  Installing pacman packages..."
        sudo pacman -S --needed --noconfirm $PACMAN_PACKAGES
    else
        echo "  No pacman packages found, skipping."
    fi
else
    echo "  Pacman directory not found, skipping."
fi

# --- AUR packages ---
if [ -d "$YAY_DIR" ]; then
    YAY_PACKAGES=$(cat "$YAY_DIR"/packages_*.txt 2>/dev/null | grep -v '^\s*#' | grep -v '^\s*$' | tr '\n' ' ')
    if [ -n "$YAY_PACKAGES" ]; then
        echo "  Installing AUR packages..."
        yay -S --needed --noconfirm $YAY_PACKAGES
    else
        echo "  No AUR packages found, skipping."
    fi
else
    echo "  Yay directory not found, skipping."
fi

echo "  Packages installed successfully."
