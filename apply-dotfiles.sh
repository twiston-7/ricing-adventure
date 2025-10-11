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
cp -r ./dotfiles/waybar ~/.config/waybar