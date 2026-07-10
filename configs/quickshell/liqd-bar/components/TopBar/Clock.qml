import QtQuick
import Quickshell
import "../Common"
import "../../theme"

Island {
    id: root
    width: timeText.implicitWidth + 10

    TokyoNight { id: theme }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    TextIcon {
        id: timeText
        text: Qt.formatDateTime(clock.date, "hh:mm AP")
        color: theme.foreground
        font.pixelSize: 13
    }
}
