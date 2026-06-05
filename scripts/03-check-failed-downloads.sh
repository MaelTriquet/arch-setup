#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

LOG="$REPO_DIR/failed-download.log"
PACMAN_DIR="$REPO_DIR/packages/pacman"
YAY_DIR="$REPO_DIR/packages/yay"

echo "==> Checking for packages that failed to download..."
: > "$LOG"

check_pkgs() {
    local source_label="$1"; shift
    local files=("$@")
    if [ ${#files[@]} -eq 0 ]; then
        return
    fi
    cat "${files[@]}" 2>/dev/null | grep -v '^\s*#' | grep -v '^\s*$' | sort -u | while IFS= read -r pkg; do
        if ! pacman -Q "$pkg" &>/dev/null 2>&1; then
            echo "$pkg" >> "$LOG"
        fi
    done
}

# Check pacman packages
if [ -d "$PACMAN_DIR" ]; then
    pacman_files=("$PACMAN_DIR"/packages_*.txt)
    check_pkgs "pacman" "${pacman_files[@]}"
fi

# Check yay packages
if [ -d "$YAY_DIR" ]; then
    yay_files=("$YAY_DIR"/packages_*.txt)
    check_pkgs "yay" "${yay_files[@]}"
fi

if [ -s "$LOG" ]; then
    count=$(wc -l < "$LOG")
    echo "  $count package(s) failed to download. See $LOG"
else
    echo "  All packages installed successfully."
fi
