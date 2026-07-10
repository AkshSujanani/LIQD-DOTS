import QtQuick
import "../theme"

Polling {
    TokyoNight { id: theme }

    interval: theme.networkRefreshMs
    script: "if command -v nmcli >/dev/null 2>&1; then wifi=$(nmcli -t -f active,ssid,signal dev wifi 2>/dev/null | awk -F: '$1==\"yes\" {print $2 \" \" $3 \"%\"; exit}'); wired=$(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION dev 2>/dev/null | awk -F: '$2==\"ethernet\" && $3==\"connected\" {print \"wired \" ($4 ? $4 : $1); exit}'); [ -n \"$wifi\" ] && printf '%s\\n' \"$wifi\" || [ -n \"$wired\" ] && printf '%s\\n' \"$wired\" || printf 'offline\\n'; else printf 'net --\\n'; fi"
}
