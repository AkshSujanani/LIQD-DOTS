import QtQuick
import "../theme"

Polling {
    TokyoNight { id: theme }

    interval: theme.systemRefreshMs
    script: "read cpu user nice system idle rest < /proc/stat; total=$((user+nice+system+idle)); prev=$(cat /tmp/liqd-bar-cpu 2>/dev/null || printf '0 0'); set -- $prev; ptotal=${1:-0}; pidle=${2:-0}; dt=$((total-ptotal)); di=$((idle-pidle)); [ \"$dt\" -gt 0 ] && cpu=$((100*(dt-di)/dt)) || cpu=0; printf '%s %s\\n' \"$total\" \"$idle\" > /tmp/liqd-bar-cpu; mem=$(awk '/MemTotal:/ {t=$2} /MemAvailable:/ {a=$2} END {print int((t-a)*100/t) \"%\"}' /proc/meminfo); printf 'cpu %s%% ram %s\\n' \"$cpu\" \"$mem\""
}
