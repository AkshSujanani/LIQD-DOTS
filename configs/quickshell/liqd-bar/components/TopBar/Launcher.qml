import QtQuick
import Quickshell
import "../Common"
import "../../theme"

Island {
    TokyoNight { id: theme }

    onClicked: Quickshell.execDetached(["sh", "-c", "rofi -show drun -config /etc/xdg/rofi/config.rasi || rofi -show drun"])

    TextIcon {
        text: ""
        color: theme.blue
        font.pixelSize: 17
    }
}
