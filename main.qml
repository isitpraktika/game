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
        if(collision == 2){
        bg.stop()
        gameOver = true}
    }
    Background {
        id: bg
    }

    ListModel {
        id: obstacles
    }
    Repeater {
        model: obstacles
        Obstacle {
            Component.onCompleted: {
                boom.connect(game.boom)
                boom.connect(player.boom)
            }
            x:  ox + globalX
            y: oy
            playerX: player.x
            playerY: player.y
            playerW: player.width
            playerH: player.height
        }
    }
    Timer{
        running: true
        repeat: true
        id:rocketT
        interval: 1000
        onTriggered: {obstacles.append({"ox":count*300 + 1800,"oy":player.y}); count ++}
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
        x:800
        y:300

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



