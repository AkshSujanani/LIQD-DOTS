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
    NetworkDetailsService { id: network }

    anchor.window: popup.anchorWindow
    anchor.rect.x: popup.anchorX
    anchor.rect.y: popup.anchorY
    width: 330
    height: 380
    visible: false
    grabFocus: true
    color: "transparent"

    onVisibleChanged: if (visible) network.refresh()

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
                        text: network.wifiEnabled ? "󰤨" : "󰤭"
                        color: network.wifiEnabled ? theme.cyan : theme.muted
                        font.family: theme.fontFamily
                        font.pixelSize: 16
                        font.bold: true
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 2
                    Text {
                        text: "Network"
                        color: theme.foreground
                        font.family: theme.fontFamily
                        font.pixelSize: 14
                        font.bold: true
                    }
                    Text {
                        Layout.fillWidth: true
                        text: network.current
                        color: theme.muted
                        font.family: theme.fontFamily
                        font.pixelSize: 11
                        elide: Text.ElideRight
                    }
                }

                Rectangle {
                    width: 46
                    height: 24
                    radius: 12
                    color: network.wifiEnabled ? theme.cyan : theme.surfaceAlt
                    border.color: theme.border
                    Rectangle {
                        width: 18
                        height: 18
                        radius: 9
                        y: 3
                        x: network.wifiEnabled ? 25 : 3
                        color: theme.foreground
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: network.toggleWifi()
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 32
                radius: 10
                color: scanMouse.containsMouse ? theme.surfaceAlt : theme.surface
                border.color: theme.border

                Text {
                    anchors.centerIn: parent
                    text: network.scanning ? "Scanning..." : "Rescan networks"
                    color: network.scanning ? theme.yellow : theme.foreground
                    font.family: theme.fontFamily
                    font.pixelSize: 11
                    font.bold: true
                }

                MouseArea {
                    id: scanMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: network.rescan()
                }
            }

            Text {
                text: network.networks.length > 0 ? "Available WiFi" : "No WiFi networks listed"
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
                model: network.networks

                delegate: Rectangle {
                    required property var modelData

                    width: ListView.view.width
                    height: 44
                    radius: 10
                    color: mouse.containsMouse ? theme.surfaceAlt : theme.surface
                    border.color: modelData.active ? theme.cyan : theme.border

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        spacing: 8

                        Text {
                            text: modelData.signal >= 75 ? "󰤨" : (modelData.signal >= 45 ? "󰤥" : "󰤟")
                            color: modelData.active ? theme.cyan : theme.foreground
                            font.family: theme.fontFamily
                            font.pixelSize: 14
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 1
                            Text {
                                Layout.fillWidth: true
                                text: modelData.ssid
                                color: theme.foreground
                                font.family: theme.fontFamily
                                font.pixelSize: 11
                                font.bold: true
                                elide: Text.ElideRight
                            }
                            Text {
                                text: (modelData.active ? "Connected  " : "") + modelData.signal + "%" + (modelData.secure ? "  secure" : "")
                                color: theme.muted
                                font.family: theme.fontFamily
                                font.pixelSize: 9
                            }
                        }
                    }

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (!modelData.active)
                                network.connectKnown(modelData.ssid)
                        }
                    }
                }
            }

            Text {
                Layout.fillWidth: true
                text: "Known networks connect directly. New secured networks still need nmcli or your normal NetworkManager tooling."
                color: theme.muted
                font.family: theme.fontFamily
                font.pixelSize: 9
                wrapMode: Text.WordWrap
            }
        }
    }
}
