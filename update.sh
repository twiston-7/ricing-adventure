#!/bin/bash
bash apply-dotfiles.sh
hyprctl reload
nohup hyprpaper &>/dev/null &
killall -SIGUSR2 waybar