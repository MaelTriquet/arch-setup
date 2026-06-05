#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
PACMAN_DIR="$REPO_DIR/packages/pacman"

sudo -v

if [ -d "$PACMAN_DIR" ]; then
    PACMAN_PACKAGES=$(cat "$PACMAN_DIR"/packages_*.txt 2>/dev/null | grep -v '^\s*#' | grep -v '^\s*$' | tr '\n' ' ')
    if [ -n "$PACMAN_PACKAGES" ]; then
        echo "  Syncing pacman databases..."
        sudo pacman -Sy --noconfirm
        echo "  Installing pacman packages..."
        # shellcheck disable=SC2086
        sudo pacman -S --needed --noconfirm $PACMAN_PACKAGES || true
    else
        echo "  No pacman packages found, skipping."
    fi
else
    echo "  Pacman directory not found, skipping."
fi

echo "  Pacman packages done."
