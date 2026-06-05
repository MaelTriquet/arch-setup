#!/bin/bash
# scripts/02-1-pacman.sh
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGES_DIR="$REPO_DIR/packages/pacman"

echo "==> Installing pacman packages..."

if [ ! -d "$PACKAGES_DIR" ]; then
    echo "  No pacman packages directory found at $PACKAGES_DIR, skipping."
    exit 0
fi

# Collect all packages from all files, stripping comments and empty lines
PACKAGES=$(cat "$PACKAGES_DIR"/*.txt | grep -v '^\s*#' | grep -v '^\s*$' | tr '\n' ' ')

if [ -z "$PACKAGES" ]; then
    echo "  No packages found, skipping."
    exit 0
fi

sudo pacman -S --needed --noconfirm $PACKAGES || true

echo "  Pacman packages installed successfully."
