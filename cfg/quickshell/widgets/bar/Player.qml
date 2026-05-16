import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import qs.components.barItem
import qs.singletons.config

BarItem {
    property var current: Mpris.players.values.find(player => player.trackArtist)

    Text {
        text: current ? `${current.trackArtist} - ${current.trackTitle}` : "No music player found"
        color: Config.theme.text
        font.family: "Maple Mono NF"

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: current?.togglePlaying()
        }
    }
}
