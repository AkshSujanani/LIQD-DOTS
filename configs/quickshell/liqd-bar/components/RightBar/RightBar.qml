import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../theme"
import "../Popups"

PanelWindow {
    id: root

    TokyoNight { id: theme }

    anchors {
        top: true
        right: true
        bottom: true
    }

    implicitWidth: theme.rightBarWidth + 6
    color: "transparent"

    Rectangle {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 3
        width: theme.rightBarWidth
        radius: theme.radius
        color: theme.transparentPanel
        border.color: theme.border
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 4
            spacing: theme.gap

            PowerButton { Layout.alignment: Qt.AlignHCenter }
            NetworkButton {
                Layout.alignment: Qt.AlignHCenter
                popupAnchorWindow: root
                tooltipY: y
                onOpenRequested: {
                    networkPopup.visible = !networkPopup.visible;
                    if (networkPopup.visible) {
                        bluetoothPopup.visible = false;
                        wallpaperPopup.visible = false;
                    }
                }
            }
            BluetoothButton {
                Layout.alignment: Qt.AlignHCenter
                popupAnchorWindow: root
                tooltipY: y
                onOpenRequested: {
                    bluetoothPopup.visible = !bluetoothPopup.visible;
                    if (bluetoothPopup.visible) {
                        networkPopup.visible = false;
                        wallpaperPopup.visible = false;
                    }
                }
            }
            WallpaperButton {
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    wallpaperPopup.visible = !wallpaperPopup.visible;
                    if (wallpaperPopup.visible) {
                        networkPopup.visible = false;
                        bluetoothPopup.visible = false;
                    }
                }
            }
            ScreenshotButton { Layout.alignment: Qt.AlignHCenter }

            Item { Layout.fillHeight: true }
            Workspaces { Layout.alignment: Qt.AlignHCenter }
            Item { Layout.fillHeight: true }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 8
                height: 8
                radius: 4
                color: theme.purple
                opacity: 0.8
            }
        }
    }

    NetworkPopup {
        id: networkPopup
        anchorWindow: root
        anchorX: -width - 8
        anchorY: 44
    }

    BluetoothPopup {
        id: bluetoothPopup
        anchorWindow: root
        anchorX: -width - 8
        anchorY: 76
    }

    WallpaperPopup {
        id: wallpaperPopup
        anchorWindow: root
        anchorX: -width - 8
        anchorY: 108
    }
}
