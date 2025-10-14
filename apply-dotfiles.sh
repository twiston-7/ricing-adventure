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

mkdir -p ~/.local/bin
mv ~/.config/waybar/power-menu.sh ~/.local/bin/power-menu.sh
chmod +x ~/.local/bin/power-menu.sh

# Rofi config
rm -rf ~/.config/wofi
cp -r ./dotfiles/wofi ~/.config/wofi
sed -i "s|\$HOME|$HOME|g" ~/.config/wofi/config

# Kitty config
rm -rf ~/.config/kitty
cp -r ./dotfiles/kitty ~/.config/kitty

# Fastfetch config
rm -rf ~/.config/fastfetch
mkdir -p ~/.config/fastfetch

# Omzsh config
rm -rf ~/.zshrc
cp ./dotfiles/omzsh/.zshrc ~/.zshrc