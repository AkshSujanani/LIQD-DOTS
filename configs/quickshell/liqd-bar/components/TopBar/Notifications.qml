import QtQuick
import Quickshell
import "../Common"
import "../../theme"

ModuleButton {
    TokyoNight { id: theme }

    text: "󰂚"
    accent: theme.purple
    onClicked: Quickshell.execDetached(["sh", "-c", "command -v swaync-client >/dev/null 2>&1 && swaync-client -t"])
}
