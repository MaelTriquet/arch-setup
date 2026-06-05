#!/bin/bash
set -e

echo "==> Bootstrapping yay..."

if command -v yay &>/dev/null; then
    echo "  yay already installed, skipping."
    exit 0
fi

# Dependencies for building yay
sudo pacman -S --needed --noconfirm git base-devel

# Build and install yay from AUR
BUILD_DIR=$(mktemp -d)
git clone https://aur.archlinux.org/yay.git "$BUILD_DIR/yay"
cd "$BUILD_DIR/yay"
makepkg -si --noconfirm

# Cleanup
rm -rf "$BUILD_DIR"

echo "  yay installed successfully."
