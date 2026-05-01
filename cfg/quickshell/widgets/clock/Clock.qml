import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland
import qs.singletons.config
import qs.singletons.time

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData
        color: "transparent"
        WlrLayershell.layer: WlrLayer.Bottom

        anchors {
            top: true
            bottom: true
            right: true
            left: true
        }

        Text {
            id: content
            color: Config.theme.text
            text: Time.time
            layer.enabled: true

            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowBlur: 0.4
                shadowOpacity: 0.5
                shadowColor: Config.theme.crust
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 125
            }

            font {
                family: "Maple Mono NF"
                pointSize: 65
                weight: 700
            }
        }
    }
}
