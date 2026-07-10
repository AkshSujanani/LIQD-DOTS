import QtQuick
import Quickshell.Io

Item {
    id: root

    visible: false

    property int barCount: 24
    property int maxRange: 100
    property bool live: false
    property var values: []
    property bool processRunning: true

    function zeroValues() {
        const next = [];
        for (let i = 0; i < barCount; i++)
            next.push(0);
        values = next;
    }

    function updateFrame(frame) {
        const parts = frame.trim().split(";").filter(part => part.length > 0);
        const next = [];

        for (let i = 0; i < parts.length && next.length < barCount; i++) {
            const value = Number(parts[i]);
            if (!isNaN(value))
                next.push(Math.max(0, Math.min(maxRange, value)));
        }

        if (next.length === 0)
            return;

        while (next.length < barCount)
            next.push(0);

        live = true;
        values = next;
    }

    Component.onCompleted: zeroValues()

    onBarCountChanged: zeroValues()

    Process {
        id: cavaProcess

        running: root.processRunning
        command: ["sh", "-c", "command -v cava >/dev/null 2>&1 || exit 127; exec cava -p /etc/nixos/configs/quickshell/liqd-bar/scripts/cava-quickshell.conf"]

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => root.updateFrame(data)
        }

        stderr: SplitParser {
            splitMarker: "\n"
            onRead: data => {}
        }

        onExited: {
            root.processRunning = false;
            root.live = false;
            root.zeroValues();
            restartTimer.restart();
        }
    }

    Timer {
        id: restartTimer

        interval: 5000
        repeat: false
        onTriggered: root.processRunning = true
    }
}
