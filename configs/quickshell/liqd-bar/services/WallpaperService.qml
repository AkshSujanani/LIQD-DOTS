import QtQuick
import Quickshell.Io

Item {
    id: root

    visible: false

    readonly property string wallpaperDir: "/etc/nixos/configs/wallpapers"
    property string stateBase: ""
    readonly property string stateDir: stateBase.length > 0 ? stateBase + "/liqd-shell" : ""
    readonly property string stateFile: stateDir.length > 0 ? stateDir + "/wallpaper" : ""
    property string selectedPath: ""
    property var wallpapers: []
    property bool loading: false
    property string pendingRestorePath: ""
    property int restoreAttempts: 0

    Commands { id: commands }

    function basename(path) {
        const parts = String(path || "").split("/");
        return parts.length > 0 ? parts[parts.length - 1] : "";
    }

    function fileUrl(path) {
        return "file://" + String(path || "").split("/").map(part => encodeURIComponent(part)).join("/");
    }

    function isSupported(path) {
        return /\.(png|jpe?g|webp|gif)$/i.test(String(path || ""));
    }

    function refresh() {
        loading = true;
        discoverProc.exec(discoverProc.command);
    }

    function apply(path) {
        if (!isSupported(path))
            return;

        pendingRestorePath = "";
        selectedPath = path;
        commands.run(["awww", "img", "--resize", "crop", "--transition-type", "fade", "--transition-duration", "0.5", path]);
        save(path);
    }

    function save(path) {
        if (stateDir.length === 0 || stateFile.length === 0)
            return;

        commands.run(["sh", "-c", "mkdir -p \"$2\" && printf '%s\\n' \"$1\" > \"$3\"", "liqd-wallpaper-save", path, stateDir, stateFile]);
    }

    function restore(path) {
        if (!isSupported(path))
            return;

        pendingRestorePath = path;
        restoreAttempts = 0;
        restoreTimer.restart();
    }

    Process {
        id: stateProc
        command: ["sh", "-c", "printf '%s\\n' \"${XDG_STATE_HOME:-$HOME/.local/state}\""]

        stdout: StdioCollector {
            onStreamFinished: {
                root.stateBase = text.trim();
                if (root.stateFile.length > 0)
                    readStateProc.exec(readStateProc.command);
            }
        }
    }

    Process {
        id: readStateProc
        command: ["sh", "-c", "[ -r \"$1\" ] && cat \"$1\" || true", "liqd-wallpaper-read", root.stateFile]

        stdout: StdioCollector {
            onStreamFinished: {
                const path = text.trim();
                if (path.length > 0) {
                    root.selectedPath = path;
                    root.restore(path);
                }
            }
        }
    }

    Process {
        id: discoverProc
        command: [
            "find", root.wallpaperDir,
            "-maxdepth", "1",
            "-type", "f",
            "(",
            "-iname", "*.png",
            "-o", "-iname", "*.jpg",
            "-o", "-iname", "*.jpeg",
            "-o", "-iname", "*.webp",
            "-o", "-iname", "*.gif",
            ")",
            "-print"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const rows = text.split("\n").map(path => path.trim()).filter(path => root.isSupported(path));
                root.wallpapers = rows.map(path => ({
                    path,
                    name: root.basename(path),
                    isGif: /\.gif$/i.test(path)
                })).sort((a, b) => a.name.toLowerCase().localeCompare(b.name.toLowerCase()));
                root.loading = false;
            }
        }

        onExited: if (exitCode !== 0) root.loading = false
    }

    Process {
        id: restoreProc

        onExited: {
            if (exitCode !== 0 && root.pendingRestorePath.length > 0 && root.restoreAttempts < 4) {
                root.restoreAttempts += 1;
                restoreTimer.restart();
                return;
            }

            root.pendingRestorePath = "";
        }
    }

    Timer {
        id: restoreTimer
        interval: 900
        repeat: false
        onTriggered: {
            if (root.pendingRestorePath.length === 0)
                return;

            root.selectedPath = root.pendingRestorePath;
            restoreProc.exec(["awww", "img", "--resize", "crop", "--transition-type", "fade", "--transition-duration", "0.5", root.pendingRestorePath]);
        }
    }

    Component.onCompleted: {
        stateProc.exec(stateProc.command);
        refresh();
    }
}
