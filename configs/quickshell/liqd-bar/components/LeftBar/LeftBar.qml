import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../theme"

PanelWindow {
    id: root

    TokyoNight { id: theme }

    anchors {
        top: true
        left: true
        bottom: true
    }

    implicitWidth: 46
    color: "transparent"

    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 6
        width: 38
        radius: theme.radius
        color: theme.transparentPanel
        border.color: theme.border
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 8

            SidebarButton {
                text: ""
                accent: theme.blue
                command: ["sh", "-c", "rofi -show drun -config /etc/xdg/rofi/config.rasi || rofi -show drun"]
                Layout.alignment: Qt.AlignHCenter
            }

            SidebarButton {
                text: ""
                accent: theme.cyan
                command: ["rofi", "-show", "drun"]
                Layout.alignment: Qt.AlignHCenter
            }

            Item { Layout.fillHeight: true }

            SidebarButton {
                text: "󰒓"
                accent: theme.purple
                command: ["sh", "-c", "rofi -show drun -filter settings"]
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
