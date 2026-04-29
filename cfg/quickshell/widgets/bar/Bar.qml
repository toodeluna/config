import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import qs.singletons.config

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: root

        required property var modelData

        screen: modelData
        exclusiveZone: 44
        implicitHeight: root.exclusiveZone + 10
        color: "transparent"

        anchors {
            top: true
            right: true
            left: true
        }

        RowLayout {
            anchors {
                fill: parent
                leftMargin: 10
                topMargin: 10
                rightMargin: 10
                bottomMargin: root.implicitHeight - root.exclusiveZone
            }

            Workspaces {}
        }
    }
}
