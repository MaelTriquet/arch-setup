#!/bin/bash
# scripts/02-2-yay.sh
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGES_DIR="$REPO_DIR/packages/yay"

echo "==> Installing AUR packages..."

if [ ! -d "$PACKAGES_DIR" ]; then
    echo "  No AUR packages directory found at $PACKAGES_DIR, skipping."
    exit 0
fi

PACKAGES=$(cat "$PACKAGES_DIR"/*.txt | grep -v '^\s*#' | grep -v '^\s*$' | tr '\n' ' ')

if [ -z "$PACKAGES" ]; then
    echo "  No packages found, skipping."
    exit 0
fi

yay -S --needed --noconfirm $PACKAGES || true

echo "  AUR packages installed successfully."
