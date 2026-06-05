##!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$REPO_DIR/scripts"

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log()     { echo -e "${GREEN}==>${NC} $1"; }
warn()    { echo -e "${YELLOW}  warning:${NC} $1"; }
die()     { echo -e "${RED}  error:${NC} $1"; exit 1; }

# --- Sanity checks ---
[ "$EUID" -eq 0 ] && die "Do not run install.sh as root. It will sudo when needed."
command -v git  &>/dev/null || die "git is not installed."
command -v stow &>/dev/null || warn "stow is not installed yet — run stow step after packages."

# --- Argument parsing ---
# Usage: ./install.sh [step]
# Example: ./install.sh 03-hyprland
STEP="${1:-}"

run_step() {
    local script="$SCRIPTS_DIR/$1.sh"
    if [ -n "$STEP" ] && [ "$STEP" != "$1" ]; then
        return 0
    fi
    if [ ! -f "$script" ]; then
        warn "Script $script not found, skipping."
        return 0
    fi
    log "Running $1..."
    bash "$script"
    log "$1 done."
}

sudo -v
# --- Steps ---
run_step 01-aur
run_step 02-1-pacman
run_step 02-2-yay
run_step 03-check-failed-downloads
# run_step 03-hyprland     # uncomment as you build these out
# run_step 04-services
# run_step 05-apps

# --- Stow dotfiles ---
if [ -z "$STEP" ] || [ "$STEP" = "stow" ]; then
    log "Stowing dotfiles..."
    bash "$REPO_DIR/update.sh"
fi

log "Installation complete." The installation script
