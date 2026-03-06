import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.config

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "wallpaper"
        WlrLayershell.layer: WlrLayer.Background

        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }

        Image {
            anchors.fill: parent
            asynchronous: true
            source: Config.wallpaper
            fillMode: Image.PreserveAspectCrop
        }
    }
}
