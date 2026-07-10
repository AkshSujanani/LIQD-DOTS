import Quickshell
import QtQuick
import QtQuick.Layouts
import "../Common"
import "../../theme"

PopupWindow {
    id: popup

    property var anchorWindow
    property int anchorX: 0
    property int anchorY: 0
    property date shownMonth: new Date()

    function monthStart() {
        return new Date(shownMonth.getFullYear(), shownMonth.getMonth(), 1);
    }

    function daysInMonth() {
        return new Date(shownMonth.getFullYear(), shownMonth.getMonth() + 1, 0).getDate();
    }

    function cellText(index) {
        const first = monthStart().getDay();
        const day = index - first + 1;
        return day > 0 && day <= daysInMonth() ? String(day) : "";
    }

    function isToday(index) {
        const now = new Date();
        const first = monthStart().getDay();
        const day = index - first + 1;
        return day === now.getDate()
            && shownMonth.getMonth() === now.getMonth()
            && shownMonth.getFullYear() === now.getFullYear();
    }

    function shiftMonth(delta) {
        shownMonth = new Date(shownMonth.getFullYear(), shownMonth.getMonth() + delta, 1);
    }

    TokyoNight { id: theme }

    anchor.window: popup.anchorWindow
    anchor.rect.x: popup.anchorX
    anchor.rect.y: popup.anchorY
    width: 290
    height: 342
    visible: false
    grabFocus: true
    color: "transparent"

    PopupSurface {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 8

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: Qt.formatDate(new Date(), "dddd, MMMM d")
                color: theme.foreground
                font.family: theme.fontFamily
                font.pixelSize: 15
                font.bold: true
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: Qt.formatDate(popup.shownMonth, "MMMM yyyy")
                color: theme.purple
                font.family: theme.fontFamily
                font.pixelSize: 13
                font.bold: true
            }

            GridLayout {
                Layout.fillWidth: true
                columns: 7
                rowSpacing: 6
                columnSpacing: 6

                Repeater {
                    model: ["S", "M", "T", "W", "T", "F", "S"]
                    Text {
                        required property string modelData
                        Layout.preferredWidth: 30
                        horizontalAlignment: Text.AlignHCenter
                        text: modelData
                        color: theme.muted
                        font.family: theme.fontFamily
                        font.pixelSize: 11
                        font.bold: true
                    }
                }

                Repeater {
                    model: 42
                    Rectangle {
                        required property int index

                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 25
                        radius: 8
                        color: popup.isToday(index) ? theme.blue : (popup.cellText(index).length > 0 ? theme.surface : "transparent")
                        border.color: popup.isToday(index) ? theme.cyan : (popup.cellText(index).length > 0 ? theme.border : "transparent")
                        border.width: popup.isToday(index) ? 0 : 1

                        Text {
                            anchors.centerIn: parent
                            text: popup.cellText(parent.index)
                            color: popup.isToday(parent.index) ? theme.surface : theme.foreground
                            font.family: theme.fontFamily
                            font.pixelSize: 11
                            font.bold: popup.isToday(parent.index)
                        }
                    }
                }
            }

            Item { Layout.fillHeight: true }

            Row {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Rectangle {
                    width: 62
                    height: 28
                    radius: theme.pillRadius
                    color: prevMouse.containsMouse ? theme.purple : theme.surfaceAlt
                    border.color: prevMouse.containsMouse ? theme.cyan : theme.border

                    Text {
                        anchors.centerIn: parent
                        text: "Prev"
                        color: prevMouse.containsMouse ? theme.surface : theme.foreground
                        font.family: theme.fontFamily
                        font.pixelSize: 11
                        font.bold: true
                    }

                    MouseArea {
                        id: prevMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: popup.shiftMonth(-1)
                    }
                }

                Rectangle {
                    width: 62
                    height: 28
                    radius: theme.pillRadius
                    color: nextMouse.containsMouse ? theme.purple : theme.surfaceAlt
                    border.color: nextMouse.containsMouse ? theme.cyan : theme.border

                    Text {
                        anchors.centerIn: parent
                        text: "Next"
                        color: nextMouse.containsMouse ? theme.surface : theme.foreground
                        font.family: theme.fontFamily
                        font.pixelSize: 11
                        font.bold: true
                    }

                    MouseArea {
                        id: nextMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: popup.shiftMonth(1)
                    }
                }
            }
        }
    }
}
