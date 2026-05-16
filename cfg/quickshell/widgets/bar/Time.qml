import QtQml
import QtQuick
import Quickshell
import qs.components.barItem
import qs.singletons.config

BarItem {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        text: Qt.formatDateTime(clock.date, "  dd/MM/yyyy    hh:mm")
        color: Config.theme.text

        font {
            family: "Maple Mono NF"
        }
    }
}
