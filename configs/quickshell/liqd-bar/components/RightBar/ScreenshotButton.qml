import QtQuick
import Quickshell
import "../Common"
import "../../theme"

ModuleButton {
    TokyoNight { id: theme }

    width: 30
    text: "󰄀"
    accent: theme.cyan
    onClicked: Quickshell.execDetached(["/etc/nixos/configs/hypr/modules/screenshot.sh"])
}
