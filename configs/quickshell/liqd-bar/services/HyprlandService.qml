import QtQuick
import Quickshell.Io
import "../theme"

Polling {
    id: root

    readonly property string hyprctlPath: "/run/current-system/sw/bin/hyprctl"

    TokyoNight { id: theme }

    interval: theme.workspaceRefreshMs
    script: "if [ -x /run/current-system/sw/bin/hyprctl ]; then id=$(/run/current-system/sw/bin/hyprctl activeworkspace -j 2>/dev/null | sed -n 's/.*\"id\":[ ]*\\([0-9-]*\\).*/\\1/p' | head -n1); [ -n \"$id\" ] && printf '%s\\n' \"$id\" || printf '1\\n'; else printf '1\\n'; fi"

    function switchWorkspace(workspaceNumber) {
        const target = Number(workspaceNumber);

        if (isNaN(target) || Math.floor(target) !== target || target < 1) {
            console.warn("switchWorkspace rejected invalid workspace:", workspaceNumber);
            return;
        }

        const dispatchExpression = 'hl.dsp.focus({ workspace = "' + String(target) + '" })';
        switchProcess.lastError = "";
        switchProcess.exec([hyprctlPath, "dispatch", dispatchExpression]);
    }

    Process {
        id: switchProcess
        running: false
        property string lastError: ""

        stderr: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                const message = data.trim();
                if (message.length > 0)
                    switchProcess.lastError = switchProcess.lastError.length > 0 ? switchProcess.lastError + "\n" + message : message;
            }
        }

        onExited: (exitCode, exitStatus) => {
            if (exitCode !== 0)
                console.warn("hyprctl workspace dispatch failed:", exitCode, exitStatus, switchProcess.lastError);
        }
    }
}
