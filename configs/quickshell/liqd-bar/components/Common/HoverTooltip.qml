import Quickshell
import QtQuick
import "../../theme"

PopupWindow {
    id: popup

    property var anchorWindow
    property int anchorX: 0
    property int anchorY: 0
    property string text: ""

    TokyoNight { id: theme }

    anchor.window: popup.anchorWindow
    anchor.rect.x: popup.anchorX
    anchor.rect.y: popup.anchorY
    width: Math.max(90, label.implicitWidth + 20)
    height: 30
    color: "transparent"

    PopupSurface {
        anchors.fill: parent
        radius: 9

        Text {
            id: label
            anchors.centerIn: parent
            text: popup.text
            color: theme.foreground
            font.family: theme.fontFamily
            font.pixelSize: 10
            font.bold: true
            elide: Text.ElideRight
            width: popup.width - 16
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
