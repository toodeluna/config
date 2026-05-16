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
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                margins: margin
            }

            Workspaces {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }

        Row {
            spacing: margin

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                bottom: parent.bottom
                margins: margin
            }

            Player {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }

        Row {
            spacing: margin

            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
                margins: margin
            }

            Time {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
        }
    }
}
