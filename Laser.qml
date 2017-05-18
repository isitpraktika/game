import QtQuick 2.0

Item {
    id: laserObstacle

    signal boom()
    property int playerX: 0
    property int playerY: 0
    property int playerW: 0
    property int playerH: 0
    property int i: 0
    property int changeStates: 1

    onXChanged: {
        if (( laserObstacle.x + laser.width >= playerX && laserObstacle.x <= playerX
             && laserObstacle.y + laser.height >= playerY && laserObstacle.y <= playerY) && laserObstacle.state == "2" && player.state != "Neuyazvimiy"){

            boom()
            laserObstacle.state = "1"
            explosionTimer.start()
            collision++
        }
        if(laserObstacle.x == playerX){
            score++
        }
    }
    function changeState(){
        changeStateS = getRandom(1,2)
        if(changeStates == 1){
            laserObstacle.state = "1"
        }
        else if(changeStates == 2){
            laserObstacle.state = "2"
        }
    }

    Image {
        id: laser
        width: 40;   height: 160
        source: "assets/Obstacles/laser_off.png"
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

    Timer{
        id: laserTimer
        running: true
        repeat: true
        interval: 1000/60
    }
    Component.onCompleted: {
        laserObstacle.boom(1)
    }
    states: [
        State {
            name: "2"
            PropertyChanges {
                target: laser
                source: "assets/Obstacles/laser_on.png"
            }
        },
        State {
            name: "1"
            PropertyChanges {
                target: laser
                source: "assets/Obstacles/laser_off.png"

            }
        }
    ]

}
