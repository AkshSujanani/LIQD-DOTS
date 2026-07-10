import QtQuick
import Quickshell

QtObject {
    function run(command) {
        Quickshell.execDetached(command)
    }

    function shell(script) {
        Quickshell.execDetached(["sh", "-c", script])
    }
}
