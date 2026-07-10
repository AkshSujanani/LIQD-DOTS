import QtQuick
import Quickshell
import "../Common"
import "../../theme"

ModuleButton {
    TokyoNight { id: theme }

    width: 30
    text: "⏻"
    accent: theme.red
    onClicked: Quickshell.execDetached(["sh", "-c", "[ -x /etc/nixos/configs/rofi/scripts/power-menu.sh ] && /etc/nixos/configs/rofi/scripts/power-menu.sh || /etc/nixos/configs/quickshell/liqd-bar/scripts/power-menu.sh"])
}
