import QtQuick
import Quickshell.Io

Item {
    id: root

    visible: false
    property string script: "printf ''"
    property int interval: 5000
    property string value: ""

    Process {
        running: true
        command: ["sh", "-c", "while true; do " + root.script + "; sleep " + Math.max(0.2, root.interval / 1000).toFixed(3) + "; done"]

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => root.value = data.trim()
        }
    }
}
