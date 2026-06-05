#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
YAY_DIR="$REPO_DIR/packages/yay"

if [ -d "$YAY_DIR" ]; then
    YAY_PACKAGES=$(cat "$YAY_DIR"/packages_*.txt 2>/dev/null | grep -v '^\s*#' | grep -v '^\s*$' | tr '\n' ' ')
    if [ -n "$YAY_PACKAGES" ]; then
        echo "  Installing AUR packages..."
        # shellcheck disable=SC2086
        yay -S --needed --noconfirm --sudoloop $YAY_PACKAGES || true
    else
        echo "  No AUR packages found, skipping."
    fi
else
    echo "  Yay directory not found, skipping."
fi

echo "  Yay packages done."
