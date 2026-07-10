import QtQuick
import "../../theme"

Item {
    id: root

    TokyoNight { id: theme }

    property int radius: theme.radius
    property int edgePadding: 4
    property color backgroundColor: theme.background
    property color borderColor: theme.popupBorder
    property color glowColor: theme.popupGlow

    default property alias content: contentItem.data

    Rectangle {
        id: glow

        anchors.fill: panel
        anchors.margins: -2
        radius: panel.radius + 2
        color: "transparent"
        border.color: root.glowColor
        border.width: 1
        opacity: 0.36
        antialiasing: true
    }

    Rectangle {
        id: panel

        anchors.fill: parent
        anchors.margins: root.edgePadding
        radius: root.radius
        color: root.backgroundColor
        border.color: root.borderColor
        border.width: 1
        clip: true
        antialiasing: true

        Item {
            id: contentItem

            anchors.fill: parent
        }
    }
}
