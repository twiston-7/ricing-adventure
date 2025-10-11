#!/bin/bash

# Install stuff
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git base-devel wayland hyprland wofi dolphin kitty hyprpaper hyprshot copyq waybar xorg-xwayland xdg-desktop-portal-hyprland dunst qt5-wayland qt6-wayland qt5ct qt6ct ttf-jetbrains-mono-nerd ttf-fira-code ttf-iosevka-nerd ttf-roboto ttf-ubuntu-font-family noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-liberation ttf-dejavu ttf-droid ttf-hack ttf-opensans wl-clipboard sddm feh pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber bluez bluez-utils blueman hyprlock hypridle fastfetch playerctl

# Enable le bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Enable le sounds
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl --user start pipewire pipewire-pulse wireplumber

# Main hyprland config
mkdir -p ~/.config/hypr
cp ./dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf

# Wallpaper stuff
cp ./images/wallpaper.png ~/wallpapers/wallpaper.png
sed -i "s|/\$HOME|$HOME|g" ~/.config/hypr/hyprpaper.conf

# Enable sddm and restart, donezies!
sudo systemctl enable sddm
reboot
