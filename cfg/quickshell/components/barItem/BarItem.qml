import QtQuick
import QtQuick.Effects
import qs.singletons.config

Item {
    id: root

    default property alias content: contentItem.data

    readonly property var spacing: 15
    readonly property var padding: spacing * 2

    implicitWidth: contentItem.implicitWidth + padding

    RectangularShadow {
        anchors.fill: rectangle
        radius: rectangle.radius
        blur: 10
        spread: 2
        color: Qt.alpha(Config.theme.crust, 0.5)
    }

    Rectangle {
        id: rectangle
        anchors.fill: parent
        color: Config.theme.base
        radius: 4

        Row {
            id: contentItem
            anchors.centerIn: parent
            spacing: root.spacing
        }
    }
}
