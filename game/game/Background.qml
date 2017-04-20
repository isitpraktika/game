import QtQuick 2.0

Rectangle {
    anchors.fill: parent

    Image {
        id: backgroundImage
        source: "assets/background/scrollingBackground.png"
        width:1600
        height: 600
        fillMode: Image.TileHorizontally


//        onWidthChanged: {backgroundAnimation.stop(); backgroundAnimation.to = - backgroundImage.width; backgroundAnimation.start()}
        NumberAnimation on x {
            id: backgroundAnimation
            to: - backgroundImage.width
            duration: 10000
            loops: Animation.Infinite
            running: true
        }






    }
//        PropertyAnimation {
//            target: backgroundImage
//            property: "x"
//            from: backgroundImage.width
//            to: -backgroundImage.width
//            loops: Animation.Infinite
//            duration: 1000
//            running: true
////            easing.type: Easing.InOutQuad

//           }


}
