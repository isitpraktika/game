import QtQuick 2.0


    Item {
        id: bonus

        signal bonusSignal()
        property int playerX: 0
        property int playerY: 0
        property int playerW: 0
        property int playerH: 0
        property int i: 0



        onXChanged: {
            //Проверка проводится только с активными ракетами
            if ((bonus.x + bonusImg.width >= playerX && bonus.x <= playerX
                 && bonus.y + bonusImg.height >= playerY && bonus.y <= playerY)&& bonusImg.visible == true){
                bonusSignal()
                bonusImg.visible = false

            }
        }

        Image {

            id: bonusImg
            width: 80;   height: 80
            source: "assets/Bonus.png"
            visible: true
        }

        Component.onCompleted: {
            bonus.bonusSignal(1)
        }

    }


