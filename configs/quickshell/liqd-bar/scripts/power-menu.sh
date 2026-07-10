#!/usr/bin/env bash

options="⏻ Shutdown
󰒲 Suspend
󰜉 Restart
󰌾 Lock
󰍃 Logout
"

choice=$(printf "%s\n" "$options" | rofi -dmenu -i -p "Power" -config /etc/xdg/rofi/config.rasi)

case "$choice" in
  "⏻ Shutdown")
    systemctl poweroff
    ;;
  "󰒲 Suspend")
    systemctl suspend
    ;;
  "󰜉 Restart")
    systemctl reboot
    ;;
  "󰌾 Lock")
    hyprlock
    ;;
  "󰍃 Logout")
    hyprctl dispatch exit
    ;;
esac
