import Quickshell
import QtQuick
import QtQuick.Layouts
import "../Common"
import "../../services"
import "../../theme"

PopupWindow {
    id: popup

    property var anchorWindow
    property int anchorX: 0
    property int anchorY: 0

    TokyoNight { id: theme }
    BluetoothService { id: bluetooth }

    anchor.window: popup.anchorWindow
    anchor.rect.x: popup.anchorX
    anchor.rect.y: popup.anchorY
    width: 300
    height: 330
    visible: false
    grabFocus: true
    color: "transparent"

    onVisibleChanged: if (visible) bluetooth.refresh()

    PopupSurface {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 10

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Rectangle {
                    width: 34
                    height: 34
                    radius: 10
                    color: theme.surfaceAlt
                    Text {
                        anchors.centerIn: parent
                        text: bluetooth.powered ? "󰂯" : "󰂲"
                        color: bluetooth.powered ? theme.blue : theme.muted
                        font.family: theme.fontFamily
                        font.pixelSize: 16
                        font.bold: true
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 2
                    Text {
                        text: "Bluetooth"
                        color: theme.foreground
                        font.family: theme.fontFamily
                        font.pixelSize: 14
                        font.bold: true
                    }
                    Text {
                        text: bluetooth.status === "bt --" ? "Unavailable" : (bluetooth.powered ? "Powered on" : "Powered off")
                        color: theme.muted
                        font.family: theme.fontFamily
                        font.pixelSize: 11
                    }
                }

                Rectangle {
                    width: 46
                    height: 24
                    radius: 12
                    color: bluetooth.powered ? theme.blue : theme.surfaceAlt
                    border.color: theme.border

                    Rectangle {
                        width: 18
                        height: 18
                        radius: 9
                        y: 3
                        x: bluetooth.powered ? 25 : 3
                        color: theme.foreground
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: bluetooth.togglePower()
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: theme.border
            }

            Text {
                text: bluetooth.available ? (bluetooth.devices.length > 0 ? "Devices" : "No paired or connected devices") : "Bluetooth adapter unavailable"
                color: theme.muted
                font.family: theme.fontFamily
                font.pixelSize: 11
                font.bold: true
            }

            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 6
                model: bluetooth.devices

                delegate: Rectangle {
                    required property var modelData

                    width: ListView.view.width
                    height: 42
                    radius: 10
                    color: mouse.containsMouse ? theme.surfaceAlt : theme.surface
                    border.color: modelData.connected ? theme.green : theme.border

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        spacing: 8

                        Text {
                            text: modelData.connected ? "󰂱" : "󰂯"
                            color: modelData.connected ? theme.green : theme.blue
                            font.family: theme.fontFamily
                            font.pixelSize: 14
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 1
                            Text {
                                Layout.fillWidth: true
                                text: modelData.name || modelData.address
                                color: theme.foreground
                                font.family: theme.fontFamily
                                font.pixelSize: 11
                                font.bold: true
                                elide: Text.ElideRight
                            }
                            Text {
                            text: modelData.connected ? "Connected" : (modelData.paired || modelData.bonded ? "Paired" : "Known")
                                color: theme.muted
                                font.family: theme.fontFamily
                                font.pixelSize: 9
                            }
                        }

                        Text {
                            text: modelData.connected ? "Disconnect" : "Connect"
                            color: modelData.connected ? theme.red : theme.cyan
                            font.family: theme.fontFamily
                            font.pixelSize: 10
                            font.bold: true
                        }
                    }

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: bluetooth.toggleDevice(modelData)
                    }
                }
            }
        }
    }
}
