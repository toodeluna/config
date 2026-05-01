pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string date
    property string time

    function parseCommandOutput(output) {
        const [date, time] = output.split(" ");
        root.date = date;
        root.time = time;
    }

    Process {
        id: dateProcess
        running: true
        command: ["date", `+%D\ %H:%M`]

        stdout: StdioCollector {
            onStreamFinished: parseCommandOutput(this.text)
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: dateProcess.running = true
    }
}
