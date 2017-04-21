import QtQuick 2.0

Item{
 id:spriteAnimation

 property int framesHorizontCount:0
 // колличество спрайтов по горизотали

 property int framesVerticalCount:0
 // колличество спрайтов по вертикали

 property int framesCount:(framesHorizontCount*framesVerticalCount)
 // кол-во спрайтов в файле

 property int currentFrame:0
 // текущий спрайт при анимации

 property string sourcePath:""
 // местонахождении файла со спрайтами

 property int animationSpeed:0
 // скорость анимации

 x:0
 y:0
 z:0
 clip:true

 height:spriteAnimationImage.height/framesVerticalCount
 width:spriteAnimationImage.width/framesHorizontCount
 // размер одного спрайта

 Image{
 // выводимый на эран спрайт

 id:spriteAnimationImage
 source:sourcePath

 x:-((spriteAnimation.currentFrame*spriteAnimation.width)
 -Math.floor(spriteAnimation.currentFrame/spriteAnimation.framesHorizontCount)
 *(spriteAnimation.framesHorizontCount*spriteAnimation.width))
 y:-(Math.floor(spriteAnimation.currentFrame/spriteAnimation.framesHorizontCount)*spriteAnimation.height)
 // координаты текущего спрайта
 }

}
