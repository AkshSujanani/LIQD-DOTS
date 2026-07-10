import QtQuick
import Quickshell
import "../Common"
import "../../services"
import "../../theme"

ModuleButton {
    id: root

    TokyoNight { id: theme }
    MicService { id: service }

    property string displayValue: service.value || "mic"

    function adjust(delta) {
        const current = parseInt(displayValue);
        if (!isNaN(current))
            displayValue = Math.max(0, Math.min(150, current + delta)) + "%";
    }

    text: " " + displayValue
    accent: displayValue === "muted" ? theme.red : theme.yellow

    Connections {
        target: service
        function onValueChanged() {
            root.displayValue = service.value || "mic";
        }
    }

    onClicked: {
        displayValue = displayValue === "muted" ? "mic" : "muted";
        Quickshell.execDetached(["wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "toggle"]);
    }
    onWheelUp: {
        adjust(5);
        Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SOURCE@", "5%+"]);
    }
    onWheelDown: {
        adjust(-5);
        Quickshell.execDetached(["wpctl", "set-volume", "@DEFAULT_AUDIO_SOURCE@", "5%-"]);
    }
}
