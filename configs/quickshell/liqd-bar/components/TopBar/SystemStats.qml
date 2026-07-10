import QtQuick
import "../Common"
import "../../services"
import "../../theme"

ModuleButton {
    TokyoNight { id: theme }
    SystemStatsService { id: service }

    text: "󰍛 " + (service.value || "sys")
    accent: theme.magenta
}
