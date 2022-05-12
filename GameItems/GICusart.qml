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
        width: parent.width
        height: parent.height * .3

        anchors.right: parent.right
        anchors.top: parent.top

        color: "#60000000"

        z: gameItemImage.z + 1
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
    }

    // Blur
    FastBlur {
        anchors.fill: gameItemImage
        source: gameItemImage
        radius: 48
    }

    // Drop Shadow
    DropShadow {
        width: parent.width
        height: parent.height

        source: gameItemImage

        anchors.centerIn: parent

        visible: !plainBG
        opacity: giShadowOp

        radius: giShadowRad
        samples: giShadowRad * 2 + 1
        z: gameItemImage.z - 1
    }
}
