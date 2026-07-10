import QtQuick
import "../../theme"

Rectangle {
    id: root

    signal clicked
    signal clickedAt(real x, real y)
    signal wheelUp
    signal wheelDown

    TokyoNight { id: theme }

    color: theme.transparentPanel
    radius: theme.pillRadius
    border.color: theme.border
    border.width: 1
    implicitWidth: Math.max(32, contentItem.implicitWidth + theme.pad * 2)
    implicitHeight: theme.barHeight - 10

    default property alias content: contentItem.data

    Row {
        id: contentItem
        anchors.centerIn: parent
        spacing: 5
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
            root.clicked()
            root.clickedAt(mouse.x, mouse.y)
        }
        onWheel: wheel => {
            if (wheel.angleDelta.y > 0)
                root.wheelUp()
            else if (wheel.angleDelta.y < 0)
                root.wheelDown()
        }
    }
}
