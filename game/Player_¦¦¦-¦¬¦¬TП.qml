import QtQuick 2.0
Item {
    id: player
    signal boom()
    property int maxY: 0
    property int  valY: 0
    property int collision: 0
    focus: true
    onYChanged: {

        valY = y
        if (y > maxY) {y=maxY}
        else if (y < 0) {y = 0}

    }
    //Состояния
    states: State{
        name:"Death"
        when: gameOver === true

        PropertyChanges {
           target: person
            source:"assets/Person/deadbird.png"
            rotation:760
            focus:false
            }
        }
    //Переходы состояний
    transitions: Transition {
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

    Image {
        focus: true
        id: person
        source: "assets/Person/bird.png"
        anchors.fill: parent
    }

    Timer {
        id: gravity
        repeat: true
        interval: 1000
        running: true

        onTriggered: {
            parent.y += 50
        }
    }
    Keys.onSpacePressed: y-=100

    Behavior on y {
        NumberAnimation {duration: 1000}
    }
}
