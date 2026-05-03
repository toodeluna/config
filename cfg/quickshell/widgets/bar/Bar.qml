import QtQuick
import Quickshell

Variants {
    model: Quickshell.screens

    readonly property var margin: 10
    readonly property var size: 44

    PanelWindow {
        id: root

        required property var modelData

        screen: modelData
        exclusiveZone: size
        implicitHeight: size + margin
        color: "transparent"

        anchors {
            top: true
            right: true
            left: true
        }

        Row {
            spacing: margin

            anchors {
                fill: parent
                margins: margin
            }

            Workspaces {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
    }
}
