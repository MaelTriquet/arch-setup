#!/bin/bash
# scripts/02-2-yay.sh
set -e
sudo -v

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGES_DIR="$REPO_DIR/packages/yay"

echo "==> Installing yay packages..."

if [ ! -d "$PACKAGES_DIR" ]; then
    echo "  No yay packages directory found at $PACKAGES_DIR, skipping."
    exit 0
fi

for file in "$PACKAGES_DIR"/*.txt; do
    category=$(basename "$file" .txt | sed 's/packages_//')
    PACKAGES=$(grep -v '^\s*#' "$file" | grep -v '^\s*$' | tr '\n' ' ')

    if [ -z "$PACKAGES" ]; then
        echo "  [$category] No packages listed, skipping."
        continue
    fi

    echo "  [$category] Installing..."
    yay -S --needed --noconfirm $PACKAGES || true
done

echo "  Yay packages installed successfully."

