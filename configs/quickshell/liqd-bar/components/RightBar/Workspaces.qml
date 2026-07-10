import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../services"
import "../../theme"

Column {
    id: root

    property int count: 10
    readonly property int clickTargetSize: 22
    readonly property int indicatorSize: 12
    property int optimisticWorkspace: 0
    property int optimisticFromWorkspace: 0
    readonly property int nativeWorkspace: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 0
    readonly property int authoritativeWorkspace: nativeWorkspace > 0 ? nativeWorkspace : Number(hypr.value || 1)
    readonly property int activeWorkspace: optimisticWorkspace > 0 ? optimisticWorkspace : authoritativeWorkspace

    TokyoNight { id: theme }
    HyprlandService { id: hypr }

    spacing: 4

    function clearOptimisticWorkspace() {
        optimisticWorkspace = 0;
        optimisticFromWorkspace = 0;
        optimisticTimeout.stop();
    }

    function switchWorkspace(workspaceId) {
        optimisticFromWorkspace = authoritativeWorkspace;
        optimisticWorkspace = workspaceId;
        optimisticTimeout.restart();
        hypr.switchWorkspace(workspaceId);
    }

    onAuthoritativeWorkspaceChanged: {
        if (optimisticWorkspace <= 0)
            return;

        if (authoritativeWorkspace === optimisticWorkspace || authoritativeWorkspace !== optimisticFromWorkspace)
            clearOptimisticWorkspace();
    }

    Repeater {
        model: root.count

        Item {
            required property int index
            readonly property int workspaceId: index + 1
            readonly property bool active: root.activeWorkspace === workspaceId
            property bool hovered: false

            width: root.clickTargetSize
            height: root.clickTargetSize
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: indicator

                width: root.indicatorSize
                height: root.indicatorSize
                radius: root.indicatorSize / 2
                anchors.centerIn: parent
                color: parent.active ? theme.blue : (parent.hovered ? theme.backgroundAlt : theme.surfaceAlt)
                border.color: parent.hovered ? theme.cyan : theme.border
                border.width: 1

                Behavior on color {
                    ColorAnimation { duration: 80 }
                }
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: parent.hovered = true
                onExited: parent.hovered = false
                onClicked: root.switchWorkspace(parent.workspaceId)
            }
        }
    }

    Timer {
        id: optimisticTimeout
        interval: 1200
        repeat: false
        onTriggered: root.clearOptimisticWorkspace()
    }
}
