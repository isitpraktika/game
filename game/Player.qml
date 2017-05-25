import QtQuick 2.0

Item {
    id: player
    signal boom()
    property int maxY: game.height - player.height
    property int  valY: 0
    property int collision: 0
    signal bonusSignal()
    focus: true
    function start(){
        gravity.start()
    }
    onMaxYChanged: console.log(maxY)
    //    onYChanged: {
    //        //valY = y
    //        console.log(player.y)
    //        if (player.y > maxY) {player.y=maxY}
    //        else if (y < 0) {y = 0}
    //    }

    //Состояния
    states: [State{
            name:"Death"
            when: gameOver === true

            PropertyChanges {
                target: person
                source:"assets/Person/deadbird.png"
                rotation:760
                focus:false
            }
        }
        , State {
            name: "Neuyazvimiy"
            PropertyChanges {
                target: person
                rotation:360

                // focus:true
                source:"assets/Neuyazvimimy.png"
            }
        }
    ]
    //Переходы состояний
    transitions: [Transition {
            from: ""
            to: "Death"

            reversible: false
            ParallelAnimation{
                NumberAnimation{
                    properties: "x,rotation"
                    duration: 1000

                    easing.type: Easing.InOutBounce
                }
            }
        }
        , Transition {
            from: ""
            to: "Neuyazvimiy"
            reversible: true
            ParallelAnimation{
                NumberAnimation{
                    properties: "x,rotation"
                    duration: 600
                    easing.type: Easing.InOutBounce
                }
            }
        }
    ]
    Image {
        focus: true
        id: person
        source: "assets/Person/bird.png"
        anchors.fill: parent
        width: 34
        height: 24
    }

    Timer {
        id: gravity
        repeat: true
        interval: 1000/60
        running: false
        onTriggered: {

            if (player.y > maxY) {
                player.y=maxY
                accelerate = 0
                console.log('ниже земли')

            }
            else{
                player.y += accelerate
                accelerate+=7
                console.log('над землей')
            }

        }
    }
    Keys.onSpacePressed: {
        if (player.y >= maxY ){
        player.y-=50}
        accelerate=-250
        console.log('пробел')
    }
    Behavior on y {
        NumberAnimation {duration: 1000}
    }
}

