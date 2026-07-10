import QtQuick

QtObject {
    readonly property color background: "#1a1b26"
    readonly property color backgroundAlt: "#24283b"
    readonly property color surface: "#16161e"
    readonly property color surfaceAlt: "#292e42"
    readonly property color foreground: "#c0caf5"
    readonly property color muted: "#565f89"
    readonly property color blue: "#7aa2f7"
    readonly property color cyan: "#7dcfff"
    readonly property color purple: "#bb9af7"
    readonly property color magenta: "#ff007c"
    readonly property color green: "#9ece6a"
    readonly property color yellow: "#e0af68"
    readonly property color red: "#f7768e"
    readonly property color border: "#414868"
    readonly property color popupBorder: "#33aaff"
    readonly property color popupGlow: "#33aaff"
    readonly property color transparentPanel: "#dd16161e"

    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int barHeight: 38
    readonly property int rightBarWidth: 38
    readonly property int radius: 14
    readonly property int pillRadius: 12
    readonly property int gap: 6
    readonly property int pad: 8

    readonly property int controlRefreshMs: 1000
    readonly property int workspaceRefreshMs: 500
    readonly property int networkRefreshMs: 5000
    readonly property int batteryRefreshMs: 15000
    readonly property int systemRefreshMs: 3000
}
