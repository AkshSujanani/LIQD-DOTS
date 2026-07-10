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
    WallpaperService { id: wallpaper }

    anchor.window: popup.anchorWindow
    anchor.rect.x: popup.anchorX
    anchor.rect.y: popup.anchorY
    width: 410
    height: 430
    visible: false
    grabFocus: true
    color: "transparent"

    onVisibleChanged: if (visible) wallpaper.refresh()

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

                    TextIcon {
                        anchors.centerIn: parent
                        text: "󰸉"
                        color: theme.cyan
                        font.pixelSize: 16
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 2

                    Text {
                        text: "Wallpapers"
                        color: theme.foreground
                        font.family: theme.fontFamily
                        font.pixelSize: 14
                        font.bold: true
                    }

                    Text {
                        Layout.fillWidth: true
                        text: wallpaper.selectedPath.length > 0 ? wallpaper.basename(wallpaper.selectedPath) : wallpaper.wallpapers.length + " available"
                        color: theme.muted
                        font.family: theme.fontFamily
                        font.pixelSize: 11
                        elide: Text.ElideRight
                    }
                }

                Rectangle {
                    width: 32
                    height: 28
                    radius: theme.pillRadius
                    color: refreshMouse.containsMouse ? theme.surfaceAlt : theme.surface
                    border.color: refreshMouse.containsMouse ? theme.cyan : theme.border

                    TextIcon {
                        anchors.centerIn: parent
                        text: wallpaper.loading ? "…" : "󰑓"
                        color: wallpaper.loading ? theme.yellow : theme.foreground
                        font.pixelSize: 12
                    }

                    MouseArea {
                        id: refreshMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: wallpaper.refresh()
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 1
                color: theme.border
            }

            Text {
                text: wallpaper.wallpapers.length > 0 ? "Choose wallpaper" : "No supported wallpapers found"
                color: theme.muted
                font.family: theme.fontFamily
                font.pixelSize: 11
                font.bold: true
            }

            GridView {
                id: grid

                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: wallpaper.wallpapers.length > 0
                clip: true
                model: wallpaper.wallpapers
                property int columns: Math.max(2, Math.floor(width / 112))
                cellWidth: width / columns
                cellHeight: 96

                delegate: Rectangle {
                    required property var modelData

                    width: GridView.view.cellWidth - 8
                    height: 88
                    radius: 10
                    color: thumbMouse.containsMouse ? theme.surfaceAlt : theme.surface
                    border.color: modelData.path === wallpaper.selectedPath ? theme.cyan : theme.border
                    border.width: modelData.path === wallpaper.selectedPath ? 2 : 1
                    clip: true

                    Loader {
                        anchors.fill: parent
                        sourceComponent: modelData.isGif ? gifThumb : imageThumb
                    }

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        height: 25
                        color: theme.transparentPanel

                        Text {
                            anchors.fill: parent
                            anchors.leftMargin: 7
                            anchors.rightMargin: 7
                            text: modelData.name
                            color: theme.foreground
                            font.family: theme.fontFamily
                            font.pixelSize: 9
                            font.bold: modelData.path === wallpaper.selectedPath
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }
                    }

                    Rectangle {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 6
                        width: 20
                        height: 20
                        radius: 10
                        visible: modelData.path === wallpaper.selectedPath
                        color: theme.cyan
                        border.color: theme.background

                        TextIcon {
                            anchors.centerIn: parent
                            text: ""
                            color: theme.surface
                            font.pixelSize: 10
                        }
                    }

                    MouseArea {
                        id: thumbMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: wallpaper.apply(modelData.path)
                    }

                    Component {
                        id: imageThumb

                        Image {
                            source: wallpaper.fileUrl(modelData.path)
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            cache: true
                        }
                    }

                    Component {
                        id: gifThumb

                        AnimatedImage {
                            source: wallpaper.fileUrl(modelData.path)
                            fillMode: Image.PreserveAspectCrop
                            playing: true
                            cache: true
                        }
                    }
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                visible: wallpaper.wallpapers.length === 0

                ColumnLayout {
                    anchors.centerIn: parent
                    width: parent.width - 24
                    spacing: 8

                    TextIcon {
                        Layout.alignment: Qt.AlignHCenter
                        text: "󰈉"
                        color: theme.muted
                        font.pixelSize: 24
                    }

                    Text {
                        Layout.fillWidth: true
                        text: "Add PNG, JPG, JPEG, WebP, or GIF files to /etc/nixos/configs/wallpapers."
                        color: theme.muted
                        font.family: theme.fontFamily
                        font.pixelSize: 11
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }
    }
}
