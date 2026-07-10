import QtQuick
import Quickshell.Bluetooth

Item {
    id: root

    visible: false
    readonly property var adapter: Bluetooth.defaultAdapter
    readonly property var devices: Bluetooth.devices.values
    readonly property var connectedDevices: devices.filter(device => device.connected)
    readonly property bool available: adapter !== null
    readonly property bool powered: available && adapter.enabled
    readonly property string status: !available ? "bt --" : (powered ? "on" : "off")

    function refresh() {
        // Native Bluetooth bindings update from BlueZ; this exists for popup symmetry.
    }

    function togglePower() {
        if (adapter)
            adapter.enabled = !adapter.enabled;
    }

    function toggleDevice(device) {
        if (!device)
            return;
        if (device.connected)
            device.disconnect();
        else
            device.connect();
    }
}
