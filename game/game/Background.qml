import QtQuick 2.0

Rectangle {
    anchors.fill: parent
    Image {
        id: backgroundImage
        source: "assets/background/scrollingBackground.png"
    }
    NumberAnimation on x {
             to: -backgroundImage.width
    }
}

