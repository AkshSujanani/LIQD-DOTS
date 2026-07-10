import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    visible: false
    property string current: "net --"
    property bool wifiEnabled: false
    property var networks: []
    property bool scanning: scanProc.running

    function refresh() {
        statusProc.exec(statusProc.command);
        networksProc.exec(networksProc.command);
    }

    function rescan() {
        scanProc.exec(scanProc.command);
    }

    function toggleWifi() {
        wifiEnabled = !wifiEnabled;
        Quickshell.execDetached(["nmcli", "radio", "wifi", wifiEnabled ? "on" : "off"]);
        refreshDelay.restart();
    }

    function connectKnown(ssid) {
        if (!ssid)
            return;
        Quickshell.execDetached(["nmcli", "connection", "up", "id", ssid]);
        refreshDelay.restart();
    }

    Process {
        id: statusProc
        command: ["sh", "-c", "if command -v nmcli >/dev/null 2>&1; then wifi=$(nmcli -t -f active,ssid,signal dev wifi 2>/dev/null | awk -F: '$1==\"yes\" {print $2 \" \" $3 \"%\"; exit}'); wired=$(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION dev 2>/dev/null | awk -F: '$2==\"ethernet\" && $3==\"connected\" {print \"wired \" ($4 ? $4 : $1); exit}'); radio=$(nmcli radio wifi 2>/dev/null); printf 'radio:%s\\n' \"$radio\"; [ -n \"$wifi\" ] && printf 'current:%s\\n' \"$wifi\" || [ -n \"$wired\" ] && printf 'current:%s\\n' \"$wired\" || printf 'current:offline\\n'; else printf 'radio:disabled\\ncurrent:net --\\n'; fi"]
        stdout: StdioCollector {
            onStreamFinished: {
                const rows = text.trim().split("\n");
                for (let i = 0; i < rows.length; i++) {
                    if (rows[i].indexOf("radio:") === 0)
                        root.wifiEnabled = rows[i].slice(6).trim() === "enabled";
                    if (rows[i].indexOf("current:") === 0)
                        root.current = rows[i].slice(8).trim();
                }
            }
        }
    }

    Process {
        id: networksProc
        command: ["sh", "-c", "command -v nmcli >/dev/null 2>&1 && nmcli -t -f ACTIVE,SIGNAL,SECURITY,SSID dev wifi 2>/dev/null || true"]
        stdout: StdioCollector {
            onStreamFinished: {
                const rows = text.trim().split("\n").filter(line => line.length > 0);
                const parsed = [];
                const seen = {};
                for (let i = 0; i < rows.length; i++) {
                    const parts = rows[i].split(":");
                    if (parts.length < 4)
                        continue;
                    const ssid = parts.slice(3).join(":");
                    if (!ssid || seen[ssid])
                        continue;
                    seen[ssid] = true;
                    parsed.push({
                        active: parts[0] === "yes",
                        signal: parseInt(parts[1]) || 0,
                        secure: parts[2].length > 0,
                        ssid
                    });
                }
                root.networks = parsed.sort((a, b) => {
                    if (a.active !== b.active)
                        return a.active ? -1 : 1;
                    return b.signal - a.signal;
                });
            }
        }
    }

    Process {
        id: scanProc
        command: ["nmcli", "dev", "wifi", "list", "--rescan", "yes"]
        onExited: root.refresh()
    }

    Timer {
        id: refreshDelay
        interval: 900
        repeat: false
        onTriggered: root.refresh()
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Component.onCompleted: root.refresh()
}
