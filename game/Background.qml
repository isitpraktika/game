import QtQuick 2.0

Rectangle {
    anchors.fill: parent


        Image {
                id: background
                source: "assets/background/scrollingBackground.png"
                width: 288
                height: 511
                fillMode: Image.TileHorizontally

                Timer {
                    id: backgroundAnim
                    interval: 15
                    repeat: true
                    running: true

                    onTriggered: {
                        background.x -= 1
                        background.width += 1
                    }
                }

    }

}
