import QtQuick
import Quickshell
import "../Common"
import "../../services"
import "../../theme"

ModuleButton {
    id: root

    TokyoNight { id: theme }
    PowerProfileService { id: service }

    property string displayValue: service.value || "balanced"

    function nextProfile(current) {
        if (current === "power-saver")
            return "balanced";
        if (current === "balanced")
            return "performance";
        return "power-saver";
    }

    text: "󰓅 " + displayValue
    accent: theme.purple

    Connections {
        target: service
        function onValueChanged() {
            root.displayValue = service.value || "balanced";
        }
    }

    onClicked: {
        displayValue = nextProfile(displayValue);
        Quickshell.execDetached(["sh", "-c", "if command -v powerprofilesctl >/dev/null 2>&1; then cur=$(powerprofilesctl get); profiles=$(powerprofilesctl list | sed -n 's/^[ *]*//;s/:$//p'); case \"$cur\" in power-saver) next=balanced;; balanced) next=performance;; *) next=power-saver;; esac; printf '%s\\n' \"$profiles\" | grep -qx \"$next\" && powerprofilesctl set \"$next\" || powerprofilesctl set balanced; fi"]);
    }
}
