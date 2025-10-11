#!/bin/bash

# Run the dotfiles application
bash apply-dotfiles.sh

# Reload Hyprland configuration
hyprctl reload

# Restart hyprpaper
pkill hyprpaper
nohup hyprpaper &>/dev/null &

# Check if waybar is running
if pgrep -x "waybar" > /dev/null; then
    # If running, kill it
    pkill -x waybar
fi

# Start waybar
nohup waybar &>/dev/null &