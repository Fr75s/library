import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Item {
    property var currentItem: modelData
    property var art: "./assets/logo/banner/empty.jpg"

    id: gameItem

    width: parent.width * 1.00
    height: parent.height

    // Name
    Text{
        id: collectName
        text: currentItem.name

        width: parent.width * 0.75
        z: gameItemImage.z + 2

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1

        wrapMode: Text.WordWrap

        font.family: gilroyExtraBold.name
        font.bold: true

        color: "white"
        font.pixelSize: vpx(16)
    }

    /*
    Rectangle {
        color: "black"

        width: collectName.width + vpx(20)
        height: collectName.height + vpx(10)
        anchors.centerIn: collectName

        z: gameItemImage.z + 1
    }
    */

    // Top bar
    Rectangle {
        id: customTopBar
        width: parent.width
        height: parent.height * .3

        anchors.right: parent.right
        anchors.top: parent.top

        color: "#60000000"

        z: gameItemImage.z + 1
        //radius: roundedGames ? height / roundedGamesRadiusFactor / .3 : 0
        visible: false
    }

    // Collection Image
    Image {
        id: gameItemImage
        width: parent.width
        height: parent.height

        anchors.centerIn: parent
        fillMode: Image.PreserveAspectCrop

        asynchronous: true

        source: ".././assets/logo/banner/"+cc.clearShortname(currentItem.shortName)+".jpg"
        visible: false
    }



    Rectangle {
        id: gameItemMask
        anchors.fill: parent
        visible: false

        radius: roundedGames ? height / roundedGamesRadiusFactor : 0
    }

    Rectangle {
        id: customTopMask
        width: parent.width
        height: customTopBar.height
        visible: false

        radius: roundedGames ? height / roundedGamesRadiusFactor / .3 : 0

        Rectangle {
            width: parent.width
            height: parent.height / 2

            anchors.bottom: parent.bottom
        }
    }

    OpacityMask {
        id: gameItemRounded
        anchors.fill: gameItemImage
        source: gameItemImage
        maskSource: gameItemMask
        visible: false
    }

    // Blur
    FastBlur {
        id: gameItemBlur
        visible: false
        anchors.fill: gameItemRounded
        source: gameItemRounded
        radius: 48
    }

    OpacityMask {
        id: gameItemBlurRounded
        anchors.fill: gameItemBlur
        source: gameItemBlur
        maskSource: gameItemMask
    }



    OpacityMask {
        anchors.fill: customTopBar
        source: customTopBar
        maskSource: customTopMask
    }

    // Drop Shadow
    DropShadow {
        width: parent.width
        height: parent.height

        source: gameItemBlurRounded

        anchors.centerIn: parent

        visible: !plainBG
        opacity: giShadowOp

        radius: giShadowRad
        samples: giShadowRad * 2 + 1
        z: gameItemImage.z - 1
    }
}
