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
    BluetoothService { id: bluetooth }

    function statusText() {
        if (!bluetooth.available)
            return "Bluetooth unavailable";
        if (!bluetooth.powered)
            return "Bluetooth off";
        if (bluetooth.connectedDevices.length > 0)
            return bluetooth.connectedDevices[0].name || bluetooth.connectedDevices[0].deviceName || "Bluetooth connected";
        return "Bluetooth on";
    }

    width: 30
    height: 28
    radius: theme.pillRadius
    color: mouse.containsMouse ? theme.surfaceAlt : theme.transparentPanel
    border.color: mouse.containsMouse ? theme.blue : theme.border
    border.width: 1

    Text {
        anchors.centerIn: parent
        text: bluetooth.powered ? "󰂯" : "󰂲"
        color: bluetooth.powered ? theme.blue : theme.muted
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
