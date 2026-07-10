import QtQuick
import "../Common"
import "../../services"
import "../../theme"

Rectangle {
    id: root

    property var popupAnchorWindow
    property int tooltipX: -tooltip.width - 8
    property int tooltipY: y
    signal openRequested

    TokyoNight { id: theme }
    NetworkService { id: network }

    function statusText() {
        if (!network.value || network.value === "offline")
            return "Disconnected";
        if (network.value === "net --")
            return "Network unavailable";
        if (network.value === "wired")
            return "Wired connected";
        return network.value;
    }

    width: 30
    height: 28
    radius: theme.pillRadius
    color: mouse.containsMouse ? theme.surfaceAlt : theme.transparentPanel
    border.color: mouse.containsMouse ? theme.cyan : theme.border
    border.width: 1

    Text {
        anchors.centerIn: parent
        text: "󰤨"
        color: theme.cyan
        font.family: theme.fontFamily
        font.pixelSize: 13
        font.bold: true
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.openRequested()
    }

    HoverTooltip {
        id: tooltip
        anchorWindow: root.popupAnchorWindow
        anchorX: root.tooltipX
        anchorY: root.tooltipY
        visible: mouse.containsMouse
        text: root.statusText()
    }
}
