import QtQuick 2.0

Item {
    id: pipes2

    signal boom()
    property int playerX: 0
    property int playerY: 0
    property int playerW: 0
    property int playerH: 0
    property int i: 0



    onXChanged: {
        if ((pipes2.x + pipe2.width >= playerX && pipes2.x <= playerX
             && pipes2.y + pipe2.height >= playerY && pipes2.y <= playerY)&& pipe2.visible == true && player.state != "bird2"){
            boom()
            pipes2.state = "PipeBoom2"
            explosionTimer.start()
            collision++
        }
        if(pipes2.x == playerX){
            score++
        }
    }

    Image {
        id: pipe2
        width: 80;   height: 170; rotation: 180
        source: "assets/Obstacles/Pipe.png"
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
        pipes2.boom(1)
    }
    states: [
        State {
            name: "PipeBoom2"
            PropertyChanges {
                target: pipe2
                visible:false

            }
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "PipeBoom2"
            reversible: false
        }
    ]
}
