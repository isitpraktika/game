import QtQuick 2.0

Item {
    id: pipes

    signal boom()
    property int playerX: 0
    property int playerY: 0
    property int playerW: 0
    property int playerH: 0
    property int i: 0



    onXChanged: {
        if ((pipes.x + pipe.width >= playerX && pipes.x <= playerX
             && pipes.y + pipe.height >= playerY && pipes.y <= playerY)&& pipe.visible == true && player.state != "bird2"){
            boom()
            pipes.state = "PipeBoom"
            explosionTimer.start()
            collision++
        }
        if(pipes.x == playerX){
            score++
        }
    }

    Image {
        id: pipe
        width: 80;   height: 200; rotation: 360
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
        pipes.boom(1)
    }
    states: [
        State {
            name: "PipeBoom"
            PropertyChanges {
                target: pipe
                visible:false

            }
        }
    ]
    transitions: [
        Transition {
            from: ""
            to: "PipeBoom"
            reversible: false
        }
    ]
}
