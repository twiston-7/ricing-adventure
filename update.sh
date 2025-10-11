#!/bin/bash
bash apply-dotfiles.sh
hyprctl reload
pkill hyprpaper
nohup hyprpaper &>/dev/null &
killall -SIGUSR2 waybar