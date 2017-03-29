import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    visible: true
    width: 288
    height: 511
    title: qsTr("proekt igra")

    Background {
        anchors.fill: parent
    }

    Image {
        id: nlo
        rotation: 0
        source: "file:///C:/game/game/nlo.png"
        width: 44
        height: 24
        x: (parent.width / 2 - width / 2) - 60
        y: 180
        z: 1

        onYChanged: {
            game.nloPositionChanged()
        }
    }

    Item {
        id: score
        width: 24
        height: 36
        anchors.horizontalCenter: parent.horizontalCenter
        y: 10
        z: 1
        property int count: 0
    }

    SequentialAnimation {
        id: nloRotation

        property alias from : firstMoviment.from

        PropertyAnimation {
            id: firstMoviment
            target: nlo
            properties: "rotation"
            duration: 50
            to: -50
        }

        PropertyAnimation {
            target: nlo
            properties: "rotation"
            duration: 300
            to: 40
        }
    }

    Timer {
        id: gravity

        repeat: true
        interval: 9

        onTriggered: {
            bird.y += 2
        }
    }

    PropertyAnimation {
        id: jumpAnim
        easing.type: Easing.OutQuad
        target: nlo
        properties: "y"
        duration: 300
    }
}



