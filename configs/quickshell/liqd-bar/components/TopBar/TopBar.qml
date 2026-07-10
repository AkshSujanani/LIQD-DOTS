import Quickshell
import QtQuick
import "../../theme"
import "../Popups"

PanelWindow {
    id: root

    TokyoNight { id: theme }

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: theme.barHeight + 10
    color: "transparent"

    Row {
        id: leftGroup
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        spacing: theme.gap

        Launcher {}
        MediaPlayer {}
        Cava {}
    }

    Item {
        id: centerLayer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: clockIsland.width + notifications.implicitWidth + theme.gap
        height: theme.barHeight

        Clock {
            id: clockIsland
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            onClicked: calendar.visible = !calendar.visible
        }

        Notifications {
            id: notifications
            anchors.left: clockIsland.right
            anchors.leftMargin: theme.gap
            anchors.verticalCenter: clockIsland.verticalCenter
        }
    }

    Row {
        id: rightGroup
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        spacing: theme.gap

        Audio {}
        Mic {}
        Brightness {}
        Battery {}
        PowerProfile {}
        SystemStats {}
    }

    CalendarPopup {
        id: calendar
        anchorWindow: root
        anchorX: root.width / 2 - width / 2
        anchorY: theme.barHeight + 8
    }

}
