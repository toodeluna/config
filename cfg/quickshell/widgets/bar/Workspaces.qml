import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.singletons.config

Item {
    readonly property var workspaces: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    readonly property var padding: 30
    readonly property var buttonSize: 12

    readonly property var activeColor: Config.theme.mauve
    readonly property var inactiveColor: Config.theme.overlay0

    Layout.fillHeight: true
    Layout.alignment: Qt.AlignLeft
    Layout.preferredWidth: content.implicitWidth + padding

    function focusWorkspace(name) {
        Hyprland.dispatch(`workspace ${name}`);
    }

    RectangularShadow {
        anchors.fill: rect
        radius: rect.radius
        blur: 10
        spread: 2
        color: Qt.alpha(Config.theme.crust, 0.5)
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        color: Config.theme.base
        radius: 4

        RowLayout {
            id: content
            anchors.centerIn: parent
            spacing: 16

            Repeater {
                model: workspaces

                Rectangle {
                    required property var modelData
                    readonly property var isActive: Hyprland.focusedWorkspace.name == modelData

                    width: buttonSize
                    height: buttonSize
                    radius: 100
                    color: isActive ? activeColor : inactiveColor

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: focusWorkspace(modelData)
                    }
                }
            }
        }
    }
}
