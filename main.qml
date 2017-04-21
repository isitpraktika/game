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
        ListElement {ox: 1000; oy: 0}
        ListElement {ox: 1000; oy: 100}
        ListElement {ox: 2000; oy: 200}
        ListElement {ox: 3000; oy: 300}
        ListElement {ox: 4000; oy: 400}
    }
    Repeater {
        model: obstacles
        Obstacle {
            Component.onCompleted: {
                boom.connect(game.boom)
            }
            x:  ox + globalX
            y: oy
            playerX: player.x
            playerY: player.y
            playerW: player.width
            playerH: player.height
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
        x:800
        y:300

        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("Click")
                gameOver = false
                restartButton.visible = false
                bg.start()
                //                obstacles.remove(1)
                //                obstacles.remove(3)


                //player.state = ""
            }

        }
    }

    Expl {
        id:explosion
        framesHorizontCount:5
        framesVerticalCount:1
        framesCount:(framesHorizontCount*framesVerticalCount)
        currentFrame:-1
        sourcePath:"assets/explosion.png"
        animationSpeed:40
        x:0
        y:0
    }



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


//   MouseArea {
//     anchors.fill: parent
//    onClicked: {
//    explosion.x=mouseX-explosion.width/2
//    explosion.y=mouseY-explosion.height/2
//    explosion.currentFrame=-1
//    explosionTimer.start()
//    }
//    }

}



