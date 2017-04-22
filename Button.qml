import QtQuick 2.0


Rectangle{
    id:butt
     visible: false
     x:500
     y:350
    width: 100
    height: 30

    color: "blue"

    Text{
      text: "Restart"

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

