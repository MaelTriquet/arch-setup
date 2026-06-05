#!/bin/bash
STOW_DIR="stow"

for pkg in "$STOW_DIR"/*/; do
    echo "Stowing $(basename $pkg)..."
    stow --dir="$STOW_DIR" --target="$HOME" --restow "$(basename $pkg)"
done
