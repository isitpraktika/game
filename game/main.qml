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
        console.log("Signal")
        bg.stop()
        gameOver = true
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



    Text {
        text: globalX
        color: "white"
        font.pixelSize: 64
    }

    MouseArea {
        id:mArea
        anchors.fill: parent
//       onClicked: {
//            bg.stop()

//        }
    }

}



