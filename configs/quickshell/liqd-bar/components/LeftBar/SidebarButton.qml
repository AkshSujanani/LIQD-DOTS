import QtQuick
import Quickshell
import "../../theme"

Rectangle {
    id: root

    property string text: ""
    property color accent: theme.blue
    property var command: []
    signal clicked

    TokyoNight { id: theme }

    width: 30
    height: 30
    radius: 10
    color: mouse.containsMouse ? theme.surfaceAlt : "transparent"
    border.color: mouse.containsMouse ? accent : "transparent"
    border.width: 1

    Text {
        anchors.centerIn: parent
        text: root.text
        color: root.accent
        font.family: theme.fontFamily
        font.pixelSize: 14
        font.bold: true
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.clicked();
            if (root.command.length > 0)
                Quickshell.execDetached(root.command);
        }
    }
}
