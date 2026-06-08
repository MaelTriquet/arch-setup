#!/bin/bash
# scripts/03-hyprland.sh
set -e

echo "==> Setting up Hyprland..."

# --- SDDM ---
echo "  Enabling SDDM..."
sudo systemctl enable sddm

echo "  Configuring SDDM for Wayland..."
sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/wayland.conf > /dev/null <<EOF
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell
EOF

# --- XDG user dirs ---
echo "  Setting up XDG user dirs..."
xdg-user-dirs-update

# --- Systemd user services ---
echo "  Enabling user services..."
systemctl --user enable hypridle
systemctl --user enable hyprpaper

echo "  Hyprland setup complete."
