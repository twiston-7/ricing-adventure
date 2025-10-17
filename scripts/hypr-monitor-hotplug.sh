#!/bin/sh

EXTERNALS=$(
  hyprctl monitors | awk '
    /^Monitor / { 
      name=$2
      is_external=(name ~ /^DP-|^HDMI-/)
      disabled=""
    }
    /disabled: / { 
      disabled=$2 
      if (is_external && disabled == "false") { count++ }
    }
    END { print count+0 }
  '
)

if [ "$EXTERNALS" -gt 0 ]; then
  hyprctl keyword monitor "eDP-1, disable"
  echo "Disabled internal monitor"
else
  hyprctl keyword monitor "eDP-1, 1920x1080, 0x0, 1"
  echo "Enabled internal monitor"
fi
