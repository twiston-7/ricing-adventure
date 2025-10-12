#!/bin/bash
# Main hyprland config
mkdir -p ~/.config/hypr
cp ./dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf

# Wallpaper stuff
cp ./dotfiles/hypr/hyprpaper.conf ~/.config/hypr/hyprpaper.conf
mkdir -p ~/wallpapers
cp ./images/wallpaper.png ~/wallpapers/wallpaper.png
sed -i "s|\$HOME|$HOME|g" ~/.config/hypr/hyprpaper.conf

# Waybar config
rm -rf ~/.config/waybar
mkdir -p ~/.config/waybar
cp ./dotfiles/waybar/config.jsonc ~/.config/waybar/config.jsonc

mkdir -p ~/.local/bin
cp ./dotfiles/waybar/power-menu.sh ~/.local/bin/power-menu.sh
chmod +x ~/.local/bin/power-menu.sh

cp ./dotfiles/waybar/style.css /etc/xdg/waybar/style.css