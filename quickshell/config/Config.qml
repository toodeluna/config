pragma Singleton

import QtCore
import Quickshell
import Quickshell.Io

Singleton {
    property alias wallpaper: adapter.wallpaper

    FileView {
        path: StandardPaths.locate(StandardPaths.ConfigLocation, "quickshell/config.json")
        watchChanges: true

        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        JsonAdapter {
            id: adapter

            property string wallpaper
        }
    }
}
