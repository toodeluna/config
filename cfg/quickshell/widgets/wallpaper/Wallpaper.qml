import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.singletons.config

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData
        screen: modelData

        WlrLayershell.layer: WlrLayer.Background
        WlrLayershell.exclusionMode: ExclusionMode.Ignore

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
