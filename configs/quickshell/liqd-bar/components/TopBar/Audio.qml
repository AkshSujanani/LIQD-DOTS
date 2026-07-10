import QtQuick
import Quickshell
import "../Common"
import "../../services"
import "../../theme"

ModuleButton {
    id: root

    TokyoNight { id: theme }
    AudioService { id: service }

    property string displayValue: service.value || "vol"

    function adjust(delta) {
        const current = parseInt(displayValue);
        if (!isNaN(current))
            displayValue = Math.max(0, Math.min(150, current + delta)) + "%";
    }

    text: " " + displayValue
    accent: displayValue === "muted" ? theme.red : theme.green

    Connections {
        target: service
        function onValueChanged() {
            root.displayValue = service.value || "vol";
        }
    }

    onClicked: {
        displayValue = displayValue === "muted" ? "vol" : "muted";
        Quickshell.execDetached(["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]);
    }
    onWheelUp: {
        adjust(5);
        Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+"]);
    }
    onWheelDown: {
        adjust(-5);
        Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"]);
    }
}
