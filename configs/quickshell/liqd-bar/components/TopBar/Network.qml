import QtQuick
import "../Common"
import "../../services"
import "../../theme"

ModuleButton {
    id: root

    signal openRequested

    TokyoNight { id: theme }
    NetworkService { id: service }

    text: "󰤨 " + (service.value || "net")
    accent: theme.cyan
    onClicked: openRequested()
}
