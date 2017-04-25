import QtQuick 2.0


Rectangle{
    id:butt
    visible: false
    x:500
    y:350
    width: 100
    height: 30

    color: "black"
    border.color: "gray"
    Text{
        anchors.fill: parent
        text: "Restart"
        font.pointSize: 16
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }



    states: State{
        name:"GameOver"
        when: gameOver === true

        PropertyChanges {
            target: butt
            visible: true

        }
    }

}

