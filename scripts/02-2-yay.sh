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

install_package() {
    local pkg="$1"

    if yay -S --needed --noconfirm "${pkg}-bin" 2>/dev/null; then
        echo "    [bin] $pkg"
    elif yay -S --needed --noconfirm "$pkg" 2>/dev/null; then
        echo "    [src] $pkg"
    else
        echo "    [FAILED] $pkg"
    fi
}

for file in "$PACKAGES_DIR"/*.txt; do
    category=$(basename "$file" .txt | sed 's/packages_//')
    PACKAGES=$(grep -v '^\s*#' "$file" | grep -v '^\s*$')

    if [ -z "$PACKAGES" ]; then
        echo "  [$category] No packages listed, skipping."
        continue
    fi

    echo "  [$category] Installing..."
    while IFS= read -r pkg; do
        install_package "$pkg"
    done <<< "$PACKAGES"
done

echo "  AUR packages installed successfully."
