#!/bin/bash
bash apply-dotfiles.sh
hyprctl reload
hyprctl hyprpaper reload
killall -SIGUSR2 waybar