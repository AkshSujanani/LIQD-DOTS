import QtQuick
import "../../theme"

Text {
    TokyoNight { id: theme }

    color: theme.foreground
    font.family: theme.fontFamily
    font.pixelSize: 12
    font.bold: true
    verticalAlignment: Text.AlignVCenter
}
