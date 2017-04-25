import QtQuick 2.5
import QtQuick.Window 2.2


Window {
    id: game
    visible: true
    width: 1600
    height: 600
    property bool gameOver: false
    title: qsTr("Run2.0")
    property bool initialized: false
    property int globalX: bg.x
    property int collision: 0
    property int count: 0
    signal boom()
    onBoom: {
        if(collision == 3){
            bg.stop()
            gameOver = true}
    }
    Background {
        id: bg
    }
    function getRandom(min, max){
        return Math.random() * (max - min) + min;
    }

    ListModel {
        id: obstacles
    }
    Timer{
        running: true
        repeat: true
        id:rocketT
        interval: 1000
        onTriggered: {obstacles.append({"ox":count*300 + 1800,"oy":getRandom(0,550), "speed": getRandom(2,5)}); count ++}
    }
    Repeater {
        model: obstacles
        Obstacle {
            Component.onCompleted: {
                boom.connect(game.boom)
                boom.connect(player.boom)
            }
            x:  (ox + globalX) * 0.5 * speed
            y: oy
            playerX: player.x
            playerY: player.y
            playerW: player.width
            playerH: player.height
        }
    }
    ListModel{
        id: laserObstacles
    }
    Timer{
        running: true
        repeat: true
        id:lasert
        interval: 1000
        onTriggered: {laserObstacles.append({"ox":count*300 + 1800,"oy":getRandom(0,550)}); count ++;}
    }
    Repeater{
        model: laserObstacles
        Laser{
            Component.onCompleted: {
                boom.connect(game.boom)
                boom.connect(player.boom)
            }
            x:  ox + globalX
            y:  oy
            playerX: player.x
            playerY: player.y
            playerW: player.width
            playerH: player.height
            state: " 2"
        }
    }
    Player {
        id: player
        y: game.height/2
        width: 50
        height: 50
        maxY: game.height - height
        collision: game.collision

    }

    Button{
        id:restartButton
        x:750
        y:285

        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("Click")
                gameOver = false
                restartButton.visible = false
                bg.restart()
                player.state = ""
                collision = 0

            }
        }
    }
}
