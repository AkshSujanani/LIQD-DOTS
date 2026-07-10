import QtQuick
import Quickshell
import "../Common"
import "../../services"
import "../../theme"

ModuleButton {
    id: root

    TokyoNight { id: theme }
    BrightnessService { id: service }

    property string displayValue: service.value || "br"

    function adjust(delta) {
        const current = parseInt(displayValue);
        if (!isNaN(current))
            displayValue = Math.max(0, Math.min(100, current + delta)) + "%";
    }

    text: "󰃠 " + displayValue
    accent: theme.yellow

    Connections {
        target: service
        function onValueChanged() {
            root.displayValue = service.value || "br";
        }
    }

    onWheelUp: {
        adjust(5);
        Quickshell.execDetached(["brightnessctl", "set", "5%+"]);
    }
    onWheelDown: {
        adjust(-5);
        Quickshell.execDetached(["brightnessctl", "set", "5%-"]);
    }
}
