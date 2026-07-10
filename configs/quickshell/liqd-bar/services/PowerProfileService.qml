import QtQuick
import "../theme"

Polling {
    TokyoNight { id: theme }

    interval: theme.controlRefreshMs
    script: "command -v powerprofilesctl >/dev/null 2>&1 && powerprofilesctl get 2>/dev/null || printf 'balanced\\n'"
}
