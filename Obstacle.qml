import QtQuick 2.0

Item {
    id: obstacle

    signal boom()
    property int playerX: 0
    property int playerY: 0
    property int playerW: 0
    property int playerH: 0
    property int i: 0



    onXChanged: {
        //Проверка проводится только с активными ракетами
        if ((obstacle.x + rocket.width >= playerX && obstacle.x <= playerX
             && obstacle.y + rocket.height >= playerY && obstacle.y <= playerY)&& rocket.visible == true && player.state != "Neuyazvimiy"){

            boom()
            obstacle.state = "RocketBoom"
            explosionTimer.start()
            collision++
        }
        if(obstacle.x == playerX){
            score++
        }
    }

    Image {
        id: rocket
        width: 100;   height: 80; rotation: -90
        source: "assets/Obstacles/rocket1.png"
    }
    Expl{
        width: 100
        height: 80
        id:explosion
        framesHorizontCount:5
        framesVerticalCount:1
        framesCount:(framesHorizontCount*framesVerticalCount)
        currentFrame:-1
        sourcePath:"assets/explosion.png"
        animationSpeed:40

        //y:player.y
        Timer{
            id:explosionTimer
            interval:explosion.animationSpeed
            running:false
            repeat:true

            onTriggered:{
                explosion.currentFrame++
                if (explosion.currentFrame==explosion.framesCount){
                    explosionTimer.stop()
                }
            }
        }
    }
    Component.onCompleted: {
        obstacle.boom(1)
    }
    states: [
        State {
            name: "RocketBoom"
            PropertyChanges {
                target: rocket
                visible:false

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
}
