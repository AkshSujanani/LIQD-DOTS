import QtQuick
import "../Common"
import "../../services"
import "../../theme"

Island {
    id: root
    width: 154

    TokyoNight { id: theme }
    CavaService {
        id: cava

        barCount: visualizer.barCount
    }

    Item {
        id: visualizer

        readonly property int barCount: 24
        readonly property int barWidth: 3
        readonly property int barSpacing: 2
        readonly property int minBarHeight: 2
        readonly property int maxBarHeight: height
        readonly property int barStep: barWidth + barSpacing

        width: barCount * barWidth + (barCount - 1) * barSpacing
        height: 20
        clip: true

        Repeater {
            model: visualizer.barCount

            Rectangle {
                readonly property real amplitude: cava.values.length > index ? cava.values[index] : 0

                width: visualizer.barWidth
                height: Math.max(visualizer.minBarHeight, amplitude / cava.maxRange * visualizer.maxBarHeight)
                x: index * visualizer.barStep
                anchors.bottom: parent.bottom
                radius: 1
                color: theme.cyan
                antialiasing: false

                Behavior on height {
                    NumberAnimation { duration: 50; easing.type: Easing.OutQuad }
                }
            }
        }
    }
}
