import QtQuick
import "../theme"

Polling {
    TokyoNight { id: theme }

    interval: theme.controlRefreshMs
    script: "if command -v brightnessctl >/dev/null 2>&1; then brightnessctl -m 2>/dev/null | awk -F, '{print $4}'; else printf 'br --\\n'; fi"
}
