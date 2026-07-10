import QtQuick
import "../theme"

Polling {
    TokyoNight { id: theme }

    interval: theme.controlRefreshMs
    script: "command -v wpctl >/dev/null 2>&1 && wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{v=int($2*100); if ($3==\"[MUTED]\") print \"muted\"; else print v \"%\"}' || printf 'mic --\\n'"
}
