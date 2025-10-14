#!/bin/bash
set -euo pipefail

# Install stuff
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git base-devel wayland hyprland wofi dolphin kitty hyprpaper hyprshot copyq waybar xorg-xwayland xdg-desktop-portal-hyprland dunst qt5-wayland qt6-wayland qt5ct qt6ct ttf-jetbrains-mono-nerd ttf-fira-code ttf-iosevka-nerd ttf-roboto ttf-ubuntu-font-family noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-liberation ttf-dejavu ttf-droid ttf-hack ttf-opensans wl-clipboard sddm feh pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber bluez bluez-utils blueman hyprlock hypridle fastfetch playerctl breeze-icons pavucontrol nm-connection-editor zsh

# Enable le bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Enable le sounds
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber

# Install ohmyzsh
sh -c "CHSH=yes RUNZSH=yes KEEP_ZSHRC=no OVERWRITE_CONFIRMATION=no $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Apply dotfiles
bash apply-dotfiles.sh

# Enable sddm and restart, donezies!
sudo systemctl enable sddm
reboot
