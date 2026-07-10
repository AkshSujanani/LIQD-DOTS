import QtQuick
import "../Common"
import "../../services"
import "../../theme"

ModuleButton {
    TokyoNight { id: theme }
    BatteryService { id: service }

    text: "󰁹 " + (service.value || "bat --")
    accent: service.value.indexOf("charging") >= 0 ? theme.green : theme.blue
}
