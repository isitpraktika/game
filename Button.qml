import QtQuick 2.0


Rectangle{
    property string buttonText: "Restart"
    id:butt
    visible: false
    x:600
    y:250
    width: 100
    height: 30

    color: "white"
    border.color: "green"
    Text{
        anchors.fill: parent
        text:  buttonText
        font.pointSize: 20
        color: "green"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }


}

