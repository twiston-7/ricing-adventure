#!/bin/bash
set -euo pipefail

# Install stuff
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git base-devel wayland hyprland wofi dolphin kitty hyprpaper hyprshot copyq waybar xorg-xwayland xdg-desktop-portal-hyprland dunst qt5-wayland qt6-wayland qt5ct qt6ct ttf-jetbrains-mono-nerd ttf-fira-code ttf-iosevka-nerd ttf-roboto ttf-ubuntu-font-family noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-liberation ttf-dejavu ttf-droid ttf-hack ttf-opensans wl-clipboard sddm feh pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber bluez bluez-utils blueman hyprlock hypridle fastfetch playerctl breeze-icons

# Enable le bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Enable le sounds
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber

# Apply dotfiles
bash apply-dotfiles.sh

# Disable waybar default style.css
FILE="/etc/xdg/waybar/style.css"

# Only proceed if the file exists (regular file or symlink)
if [[ -e "$FILE" ]]; then  # -e tests for existence
  ts="$(date +%Y%m%d-%H%M%S)"            # timestamp like 2025-10-12-185500
  NEW="${FILE}.disabled.${ts}"

  # Ensure target name is unique
  while [[ -e "$NEW" ]]; do
    ts="$(date +%Y%m%d-%H%M%S)-$RANDOM"
    NEW="${FILE}.disabled.${ts}"
  done

  # Use sudo if needed
  if [[ ! -w "$FILE" || ! -w "$(dirname "$FILE")" ]]; then
    sudo mv -v -- "$FILE" "$NEW"
  else
    mv -v -- "$FILE" "$NEW"
  fi

  echo "Renamed: $FILE -> $NEW"
else
  echo "No file found at: $FILE"
fi

# Enable sddm and restart, donezies!
sudo systemctl enable sddm
reboot
