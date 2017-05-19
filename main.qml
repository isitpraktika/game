import QtQuick 2.5
import QtQuick.Window 2.2
import QtMultimedia 5.5

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
    property int score: 0
    property int rand: 0
    signal boom()
    signal bonusSignal()

    onBoom: {
        if (extraHeart.visible == true){
            extraHeart.visible = false
        }
        else {
            hearts.remove(0)
            if(collision == 2 ){
                bg.stop()
                gameOver = true
                restartButton.visible = true
                exit1Button.visible = true
            }
        }
    }
    onBonusSignal: {
        rand = getRandom(1,3)
        //rand=2
        if (rand == 1 && extraHeart.visible == false ) {
             extraHeart.visible = true
            collision--
        }
        if (rand == 2){
            player.state = "bird2"
            bonusT2.running = true
        }
    }
    Background {
        id: bg
    }
    function getRandom(min, max){
        return Math.random() * (max - min) + min;
    }
    function restartHearts () {
        hearts.append({ox: 1100, oy: 100})
        hearts.append({ox: 1050, oy: 100})
        hearts.append({ox: 1000, oy: 100})
    }
    ListModel {
        id: bonuses

    }
    //Таймер продолжительности умения неуязвимости
    Timer{
        running: false
        repeat: false
        id:bonusT2
        interval: 7000
        onTriggered: {player.state = ""}

    }
    //Создает бонусы на карте
    Timer{
        running: true
        repeat: true
        id:bonusT
        interval: 3000
        onTriggered: {bonuses.append({"ox":count*300 + 1800,"oy":getRandom(0,550)}); count ++}

    }

    Repeater {
        model: bonuses
        Bonus {
            Component.onCompleted: {
                bonusSignal.connect(game.bonusSignal)
                bonusSignal.connect(player.bonusSignal)
            }
            x:  ox + globalX
            y: oy
            playerX: player.x
            playerY: player.y
            playerW: player.width
            playerH: player.height
        }
    }

    ListModel {
        id: hearts
        ListElement {ox: 1100; oy: 50}
        ListElement {ox: 1050; oy: 50}
        ListElement {ox: 1000; oy: 50}

    }
    Text {
        id: scoreText
        text: ("Пройденные препятствия: "+score)
        font.pointSize: 15
        color: "white"

    }

    ListModel {
        id: obstacles
    }
    Timer{
        running: true
        repeat: true
        id:rocketT
        interval: 1000
        onTriggered: {obstacles.append({"ox":count*300 + 1800,"oy":getRandom(20,500), "speed": getRandom(3, 5)}); count ++}

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
    ListModel {
        id: piped
    }
    Timer{
        running: true
        repeat: true
        id:pipeT
        interval: 1000
        onTriggered: {piped.append({"ox":count*400 + 1800,"oy":400}); count ++}
    }
    Repeater {
        model: piped
        Pipe {
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
    ListModel {
        id: piped2
    }
    Timer{
        running: true
        repeat: true
        id:pipe2T
        interval: 1000
        onTriggered: {piped2.append({"ox":count*400 + 1800,"oy":0}); count ++}
    }
    Repeater {
        model: piped2
        Pipe2 {
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

    Player {
        id: player
        y: game.height/2
        width: 50
        height: 50
        maxY: game.height - height
        collision: game.collision

    }
    Button{
        id:startButton
        x:600
        y:250
        visible: true
        buttonText: "Start"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                startButton.visible = false
                exitButton.visible = false
                exit1Button.visible = false
                bg.start()
                player.start()
            }
        }
    }
    Button{
        id:exitButton
        x:600
        y:280
        buttonText: "Exit"
        visible: true
        MouseArea{
            anchors.fill: parent
            onClicked: game.close()
        }
    }

    Button{
        id:restartButton
        x:600
        y:250

        MouseArea{
            anchors.fill: parent
            onClicked: {
                gameOver = false
                restartButton.visible = false
                exit1Button.visible = false
                bg.restart()
                player.state = ""
                collision = 0
                restartHearts ()
  }
        }
    }
    Button{
        id:exit1Button
        x:600
        y:280
        buttonText: "Exit"
        visible: true
        MouseArea{
            anchors.fill: parent
            onClicked:{
                game.close()

        }
    }

}
    Repeater {
        model: hearts
        Heart{
            x: ox
            y: oy
        }
    }
    Heart{
        id:extraHeart
        visible: false
        x:1100
        y:150
    }
}


