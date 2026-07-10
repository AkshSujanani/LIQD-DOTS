import QtQuick
import Quickshell
import "../../theme"

Rectangle {
    id: root

    property string text: ""
    property string tooltip: ""
    property color accent: theme.blue
    property var command: []
    signal clicked
    signal wheelUp
    signal wheelDown

    TokyoNight { id: theme }

    implicitWidth: Math.max(30, label.implicitWidth + 14)
    implicitHeight: 28
    radius: theme.pillRadius
    color: mouse.containsMouse ? theme.surfaceAlt : theme.transparentPanel
    border.color: mouse.containsMouse ? accent : theme.border
    border.width: 1

    Text {
        id: label
        anchors.centerIn: parent
        text: root.text
        color: theme.foreground
        font.family: theme.fontFamily
        font.pixelSize: 12
        font.bold: true
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: {
            root.clicked()
            if (root.command.length > 0)
                Quickshell.execDetached(root.command)
        }
        onWheel: wheel => {
            if (wheel.angleDelta.y > 0)
                root.wheelUp()
            else if (wheel.angleDelta.y < 0)
                root.wheelDown()
        }
    }
}
