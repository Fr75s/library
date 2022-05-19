import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Item {
    // The standard gameItem, showing for all instances where games are shown.
    property var currentGame: modelData
    property bool wideHead: false

    id: gameItem
    property var backColor: light ? "#EEEEEE" : "#181818"

    width: parent.width
    height: parent.height

    // Imageless backdrop
    Text {
        id: gameItemText
        anchors.fill: parent

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text: currentGame.title
        wrapMode: Text.Wrap

        font.pixelSize: vpx(16)
        font.family: gilroyLight.name
        font.bold: true

        color: light ? "black" : "white"

        Rectangle {
            id: gameItemTextBack
            anchors.fill: parent
            z: parent.z - 1

            color: light ? "#EEEEEE" : "#242424"

            LinearGradient {
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: light ? "#CCCCCC" : "black" }
                }
            }
        }
    }

    // The image itself
    Image {
        id: gameItemImage
        width: parent.width
        height: parent.height

        z: gameItemText.z + 1

        anchors.centerIn: parent
        fillMode: Image.PreserveAspectCrop

        asynchronous: true

        source: (wide || (wideHead && index == 0)) ? (currentGame.assets.steam || currentGame.assets.screenshot || currentGame.assets.background || currentGame.assets.banner || currentGame.assets.boxFront || currentGame.assets.marquee || currentGame.assets.poster) : (boxArt(currentGame))

        // For Steam games that lack portrait mode art
        onStatusChanged: {
            if (status == Image.Error) {
                // The funny
                console.log("No Steam Art?\n⠀⣞⢽⢪⢣⢣⢣⢫⡺⡵⣝⡮⣗⢷⢽⢽⢽⣮⡷⡽⣜⣜⢮⢺⣜⢷⢽⢝⡽⣝\n⠸⡸⠜⠕⠕⠁⢁⢇⢏⢽⢺⣪⡳⡝⣎⣏⢯⢞⡿⣟⣷⣳⢯⡷⣽⢽⢯⣳⣫⠇\n⠀⠀⢀⢀⢄⢬⢪⡪⡎⣆⡈⠚⠜⠕⠇⠗⠝⢕⢯⢫⣞⣯⣿⣻⡽⣏⢗⣗⠏⠀\n⠀⠪⡪⡪⣪⢪⢺⢸⢢⢓⢆⢤⢀⠀⠀⠀⠀⠈⢊⢞⡾⣿⡯⣏⢮⠷⠁⠀⠀\n⠀⠀⠀⠈⠊⠆⡃⠕⢕⢇⢇⢇⢇⢇⢏⢎⢎⢆⢄⠀⢑⣽⣿⢝⠲⠉⠀⠀⠀⠀\n⠀⠀⠀⠀⠀⡿⠂⠠⠀⡇⢇⠕⢈⣀⠀⠁⠡⠣⡣⡫⣂⣿⠯⢪⠰⠂⠀⠀⠀⠀\n⠀⠀⠀⠀⡦⡙⡂⢀⢤⢣⠣⡈⣾⡃⠠⠄⠀⡄⢱⣌⣶⢏⢊⠂⠀⠀⠀⠀⠀⠀\n⠀⠀⠀⠀⢝⡲⣜⡮⡏⢎⢌⢂⠙⠢⠐⢀⢘⢵⣽⣿⡿⠁⠁⠀⠀⠀⠀⠀⠀⠀\n⠀⠀⠀⠀⠨⣺⡺⡕⡕⡱⡑⡆⡕⡅⡕⡜⡼⢽⡻⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀⠀⠀⠀⣼⣳⣫⣾⣵⣗⡵⡱⡡⢣⢑⢕⢜⢕⡝⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀⠀⠀⣴⣿⣾⣿⣿⣿⡿⡽⡑⢌⠪⡢⡣⣣⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀⠀⠀⡟⡾⣿⢿⢿⢵⣽⣾⣼⣘⢸⢸⣞⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀⠀⠀⠀⠁⠇⠡⠩⡫⢿⣝⡻⡮⣒⢽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀");
                gameItemImage.source = currentGame.assets.boxFront;
            }
        }

        // The background for wide header
        Rectangle {
            id: wideHeadBG
            width: parent.width
            height: parent.height * .2

            anchors.right: parent.right
            anchors.bottom: parent.bottom

            visible: wide || (wideHead && index == 0)

            color: "#60000000"
        }
    }

    ShaderEffectSource{
        id: shaderSource
        sourceItem: gameItemImage
        width: gameItemImage.width
        height: gameItemImage.height * .2

        anchors{
            right: gameItemImage.right
            bottom: gameItemImage.bottom
        }

        sourceRect: Qt.rect(x,y, width, height)
    }

    GaussianBlur {
        anchors.fill: shaderSource
        source: shaderSource
        radius: 32
        samples: 30

        visible: wide || (wideHead && index == 0)
    }

    // Wide header text
    Text {
        id: wideViewText
        anchors.centerIn: shaderSource
        width: parent.width * .9
        height: parent.height * .2

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        text: currentGame.title
        wrapMode: Text.WordWrap

        visible: wide || (wideHead && index == 0)

        font.pixelSize: vpx(16)
        font.family: gilroyLight.name
        font.bold: true

        color: "white"
        z: wideHeadBG.z + 1
    }

    // Favorite Image
    Image {
        id: favImg
        width: height
        height: parent.height * .15

        anchors.top: parent.top
        anchors.topMargin: parent.height * .025
        anchors.right: parent.right
        anchors.rightMargin: parent.height * .025
        z: parent.z + 5

        source: useSVG ? "../assets/theme/favorite.svg" : "../assets/theme/favorite.png"
        mipmap: true
        //color: light ? "#242424" : "#EEEEEE"

        visible: currentGame.favorite
    }

    // Drop shadow for the item
    DropShadow {
        width: parent.width
        height: parent.height

        source: gameItemTextBack

        anchors.centerIn: parent

        visible: !plainBG
        opacity: giShadowOp

        radius: giShadowRad
        samples: giShadowRad * 2 + 1
        z: gameItemTextBack.z - 1
    }

    // Drop shadow for the favorite star
    DropShadow {
        source: favImg
        anchors.fill: favImg

        visible: favImg.visible
        spread: 0.35

        radius: 16
        samples: 17
        z: favImg.z - 1
    }


    /* Hey future me,
    * please mention this code is from shinretro by TigraTT-Driver.
    * Don't publish this on github without it.
    */

    // Box art
    function steamAppID (gameData) {
        var str = gameData.assets.boxFront.split("header");
        return str[0];
    }

    function steamBoxFront(gameData) {
        return steamAppID(gameData) + "/library_600x900_2x.jpg"
    }


    function boxArt(data, failed=false) {
        if (data != null) {
            if (data.assets.boxFront.includes("header.jpg")) {
                if (failed) {
                    return data.assets.boxFront;
                } else {
                    return steamBoxFront(data);
                }
            }
            else {
                if (data.assets.poster != "")
                    return data.assets.poster;
                else if (data.assets.boxFront != "")
                    return data.assets.boxFront;
                else if (data.assets.banner != "")
                    return data.assets.banner;
                else if (data.assets.tile != "")
                    return data.assets.tile;
                else if (data.assets.cartridge != "")
                    return data.assets.cartridge;
                else if (data.assets.logo != "")
                    return data.assets.logo;
            }
        }
        return "";
    }
}
