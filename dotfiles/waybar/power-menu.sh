#!/usr/bin/env bash
set -euo pipefail

choices="Lock
Sleep
Reboot
Shutdown"

choice=$(printf "%s\n" "$choices" | wofi --dmenu --prompt "Power" --cache-file /dev/null)
case "$choice" in
  Lock) hyprlock ;;
  Sleep) systemctl suspend ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
  *) exit 0 ;;
esac
