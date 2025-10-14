#!/usr/bin/env bash
set -euo pipefail

menu() {
  if command -v wofi >/dev/null 2>&1; then
    wofi --dmenu --prompt "Networks" --cache-file /dev/null
  elif command -v rofi >/dev/null 2>&1; then
    rofi -dmenu -p "Networks"
  elif command -v bemenu >/dev/null 2>&1; then
    bemenu -p "Networks"
  else
    cat
  fi
}

# Ensure NetworkManager is present
command -v nmcli >/dev/null 2>&1 || { notify-send "Wi-Fi" "nmcli not found"; exit 1; }

# Build menu:
# - Current connection at top
# - Toggle Wi‑Fi, Rescan, Edit connections
CURRENT="$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}' | head -n1)"
STATE="$(nmcli -g WIFI r)"
HDR=" Connected: ${CURRENT:-none}"
ACTIONS=$'Toggle Wi-Fi\nRescan\nEdit connections'

# List visible SSIDs with lock and signal bars
LIST="$(nmcli -t -f IN-USE,SECURITY,SIGNAL,SSID dev wifi | awk -F: '
  {
    used=$1=="*" ? "" : "";
    sec=$2=="" ? "󰌁" : "󰌾";
    sig=$3+0;
    if (sig>=80) bar="󰤨";
    else if (sig>=60) bar="󰤥";
    else if (sig>=40) bar="󰤢";
    else bar="󰤟";
    ssid=$4; if (ssid=="") ssid="[hidden]";
    printf "%s  %s %s  %s\n", used, bar, sec, ssid
  }' | uniq)"

CHOICE="$(printf "%s\n\n%s\n%s\n" "$HDR" "$ACTIONS" "$LIST" | menu | sed 's/^ *//')"

case "$CHOICE" in
  Toggle\ Wi-Fi)
    if [ "$STATE" = "enabled" ]; then nmcli r wifi off; else nmcli r wifi on; fi
    ;;
  Rescan)
    nmcli dev wifi rescan
    ;;
  Edit\ connections)
    if command -v nm-connection-editor >/dev/null 2>&1; then
      nm-connection-editor &
    else
      notify-send "Wi-Fi" "nm-connection-editor not installed"
    fi
    ;;
  ""|Connected:*|Networks)
    exit 0
    ;;
  *)
    SSID="${CHOICE##*  }"
    if [ "$SSID" = "[hidden]" ]; then
      SSID="$(printf "" | menu)"
    fi
    # Try to connect; prompt for password if needed
    nmcli dev wifi connect "$SSID" || {
      PASS="$(printf "" | menu)"
      nmcli dev wifi connect "$SSID" password "$PASS"
    }
    ;;
esac
