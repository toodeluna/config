import QtQml
import QtQuick
import QtQuick.Effects
import Quickshell
import qs.singletons.config

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData
        color: "transparent"
        aboveWindows: false

        anchors {
            top: true
            bottom: true
            right: true
            left: true
        }

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        Text {
            id: content
            color: Config.theme.text
            text: Qt.formatDateTime(clock.date, "hh:mm")
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
