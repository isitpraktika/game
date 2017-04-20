import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id:root
    visible: true
    width: 1600
    height: 600
    title: qsTr("Run game")

    Background {
        id: backgroundImage
        width: backgroundImage.width
        anchors.fill: parent

//        NumberAnimation {
//            target: backgroundImage
//            property: "width"
//            duration: 1000
//            easing.type: Easing.InOutQuad
//            loops: Animation.Infinite
//        }

    }

}
