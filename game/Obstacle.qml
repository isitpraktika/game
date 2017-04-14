import QtQuick 2.0


Item {
    id: obstacle

    signal boom()
    property int playerX: 0
    property int playerY: 0
    property int playerW: 0
    property int playerH: 0
    property int i: 1

    onXChanged: {

        if (obstacle.x + rocket.width >= playerX && obstacle.x <= playerX
         && obstacle.y + rocket.height >= playerY && obstacle.y <= playerY){
            boom()
            obstacle.state = "RocketBoom"
            //state = "BgStop"
            //console.log(boom())

      }


    }

    Image {
        id: rocket
        width: 100;   height: 80; rotation: -90
        source: "assets/Obstacles/rocket.png"
    }
    Component.onCompleted: {
    obstacle.boom(1)
    }
    Text {
        text: obstacle.x + " : " + obstacle.y
        font.pixelSize: 40
    }

    states: [
        State {
            name: "RocketBoom"

            PropertyChanges {
                target: rocket
                visible:false
                focus:false
            }
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "RocketBoom"
            reversible: false


        }
    ]
//    Timer{
//        running: true
//        repeat: true
//        id: rocketT
//        interval: 500

//        onTriggered: {
//            parent.x -= 300
//        }
//    }

//    Behavior on x{
//        NumberAnimation{duration: 1000}
//    }
}
