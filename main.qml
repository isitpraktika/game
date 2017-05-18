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
    property int score: 0
    property int maxScore: 0
    property int count: 0
    property int level: 0
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
            }
        }
    }
    onBonusSignal: {
        rand = getRandom(1,3)


        if (rand == 1 && extraHeart.visible == false ) {
            extraHeart.visible = true
            collision--
        }
        if (rand == 2){
            player.state = "Neuyazvimiy"
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
        hearts.append({ox: 1500, oy: 100})
        hearts.append({ox: 1450, oy: 100})
        hearts.append({ox: 1400, oy: 100})
    }
    ListModel {
        id: bonuses
    }

    Timer{
        running: false
        repeat: false
        id:bonusT2
        interval: 5000
        onTriggered: {player.state = ""}

    }
    Timer{
        running: true
        repeat: true
        id:bonusT
        interval: 4000
        onTriggered: {bonuses.append({"ox":count*300 + 1800,"oy":getRandom(0,550), "speed": getRandom(2+level,5+2*level)}); count ++}

    }

    Repeater {
        model: bonuses
        Bonus {
            Component.onCompleted: {
                bonusSignal.connect(game.bonusSignal)
                bonusSignal.connect(player.bonusSignal)
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
        id: hearts
        ListElement {ox: 1500; oy: 100}
        ListElement {ox: 1450; oy: 100}
        ListElement {ox: 1400; oy: 100}

    }

    Text {
        id: scoreText
        text: ("Очки: "+score)
        font.pointSize: 20
        color: "white"

    }
    Text {
        id: maxScoreText
        text: ("Рекорд: "+maxScore)
        font.pointSize: 20
        color: "white"
        y:30

    }


    ListModel {
        id: obstacles
    }
    Timer{
        running: true
        repeat: true
        id:rocketT
        interval: 1000
        onTriggered: {obstacles.append({"ox":count*300 + 1800,"oy":getRandom(0,550), "speed": getRandom(2+level,5+2*level)}); count ++}

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
        onTriggered: {laserObstacles.append({"ox":count*300 + 1800,"oy":getRandom(0,500)}); count ++; /*las.changeState()*/}
    }
    //Laser{id:las}
    Repeater{
        model: laserObstacles
        Laser{
            Component.onCompleted: {
                boom.connect(game.boom)
                boom.connect(player.boom)
                state = Math.round(getRandom(1,2))

            }
            x:  ox + globalX
            y:  oy
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
        x:750
        y:290
        visible: true
        buttonText: "Start"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                optionsButton.visible = false
                startButton.visible = false
                exitButton.visible = false
                bg.start()
                player.start()


            }
        }
    }
    Button{
        id:exitButton
        x:750
        y:350
        buttonText: "Exit"
        visible: true
        MouseArea{
            anchors.fill: parent
            onClicked: game.close()
        }
    }
    Button{
        id:optionsButton
        x:750
        y:320
        visible: true
        buttonText: "Options"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                startButton.visible = false
                exitButton.visible = false
                optionsButton.visible = false
                options.visible = true

            }
        }
    }

    Button{
        id:restartButton
        x:750
        y:285

        MouseArea{
            anchors.fill: parent
            onClicked: {
                gameOver = false
                restartButton.visible = false
                bg.restart()
                player.state = ""
                collision = 0
                restartHearts ()
                if (score > maxScore) maxScore = score
                score = 0
            }
        }
    }
    Options{
        id:options
        x:game.width/2-150
        y:game.height/2-150
        Button{
            id:back
            x: 0
            y: 0
            visible: true
            buttonText: "Back"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    options.visible = false
                    startButton.visible = true
                    exitButton.visible = true
                    optionsButton.visible = true

                }

            }
        }
        Text{
            font.pointSize: 17
            color: "white"
            text: "Уровень сложности "+level
            x: 10
            y: 100


        }
        Button{
            id:levelUp
            x: 250
            y: 70
            visible: true
            width: 20
            height: 20
            buttonText: "+"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    level+=1

                }

            }


        }
        Button{
            id:levelDown
            x: 250
            y: 95
            visible: true
            width: 20
            height: 20
            buttonText: "-"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(level > 0){
                        level-=1
                    }

                }

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
        x:1500
        y:150
    }
}
