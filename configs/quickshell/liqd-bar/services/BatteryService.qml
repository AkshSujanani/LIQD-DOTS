import QtQuick
import "../theme"

Polling {
    TokyoNight { id: theme }

    interval: theme.batteryRefreshMs
    script: "if command -v upower >/dev/null 2>&1; then dev=$(upower -e | grep BAT | head -n1); [ -n \"$dev\" ] && upower -i \"$dev\" | awk '/percentage:/ {p=$2} /state:/ {s=$2} END {if (p) print p \" \" s; else print \"bat --\"}' || printf 'bat --\\n'; else for b in /sys/class/power_supply/BAT*; do [ -e \"$b/capacity\" ] || continue; printf '%s %s\\n' \"$(cat \"$b/capacity\")%\" \"$(cat \"$b/status\")\"; exit; done; printf 'bat --\\n'; fi"
}
