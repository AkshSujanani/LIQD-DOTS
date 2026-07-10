import QtQuick
import Quickshell.Services.Mpris
import "../Common"
import "../../theme"

Island {
    id: root

    property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
    property bool hasPlayer: player !== null
    property bool isActive: hasPlayer && (player.isPlaying || (player.trackTitle || "").length > 0)
    property bool manuallyExpanded: false
    property bool manuallyCollapsed: false
    property bool expanded: manuallyExpanded || (isActive && !manuallyCollapsed)
    property string playerName: hasPlayer ? (player.identity || player.desktopEntry || "Media") : "Media"
    property string title: hasPlayer ? (player.trackTitle || "Unknown title") : "No media"

    width: expanded ? 178 : 32

    TokyoNight { id: theme }

    TextIcon {
        visible: !root.expanded
        text: "›"
        color: theme.purple
        font.pixelSize: 18
    }

    TextIcon {
        visible: root.expanded
        text: root.hasPlayer && root.player.isPlaying ? "" : ""
        color: root.hasPlayer ? theme.green : theme.muted
        font.pixelSize: 12
    }

    Column {
        visible: root.expanded
        width: 124
        spacing: 0

        TextIcon {
            width: parent.width
            text: root.hasPlayer ? root.playerName : "No player"
            color: theme.muted
            font.pixelSize: 9
            elide: Text.ElideRight
        }

        TextIcon {
            width: parent.width
            text: root.title
            color: theme.foreground
            font.pixelSize: 11
            elide: Text.ElideRight
        }
    }

    TextIcon {
        visible: root.expanded
        text: "‹"
        color: theme.muted
        font.pixelSize: 15
    }

    onClickedAt: (mouseX, mouseY) => {
        if (!root.expanded) {
            root.manuallyExpanded = true;
            root.manuallyCollapsed = false;
            return;
        }

        if (mouseX >= root.width - 30) {
            root.manuallyExpanded = false;
            root.manuallyCollapsed = true;
            return;
        }

        if (!root.isActive) {
            root.manuallyExpanded = false;
            return;
        }

        if (root.hasPlayer && root.player.canTogglePlaying)
            root.player.togglePlaying()
    }

    onIsActiveChanged: {
        if (!isActive) {
            manuallyExpanded = false;
            manuallyCollapsed = false;
        } else {
            manuallyCollapsed = false;
        }
    }
}
