#!/bin/bash
# Main hyprland config
mkdir -p ~/.config/hypr
cp ./dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf

# Wallpaper stuff
mkdir -p ~/wallpapers
cp ./images/wallpaper.png ~/wallpapers/wallpaper.png
sed -i "s|\$HOME|$HOME|g" ~/.config/hypr/hyprpaper.conf

# Waybar config
mkdir -p ~/.config/waybar
cp ./dotfiles/waybar/config.jsonc ~/.config/waybar/config.jsonc