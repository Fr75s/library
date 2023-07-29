import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Item {
    id: gameItem

    // The standard gameItem, showing for all instances where games are shown.
    property var currentGame: modelData
    property bool wideHead: false
    property var backColor: settings["light"] ? "#EEEEEE" : "#181818"

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

        // Max gamesRows can be is 5, i've found 5 / rows to work well for scaling
        font.pixelSize: vpx(8) * (5 / settings["gamesRows"])
        font.family: gilroyLight.name
        font.bold: true

        color: colors["text"]

        Rectangle {
            id: gameItemTextBack
            anchors.fill: parent
            z: parent.z - 1

            color: colors["plainSetting"]
            radius: settings["roundedGames"] ? height / roundedGamesRadiusFactor : 0

            LinearGradient {
                id: gameItemTextBackGradient
                source: parent
                anchors.fill: parent
                start: Qt.point(0, 0)
                end: Qt.point(0, parent.height)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: colors["giGradient"] }
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
        visible: false

        asynchronous: true

        source: (settings["wide"] || (wideHead && index == 0)) ? (currentGame.assets.steam || currentGame.assets.screenshot || currentGame.assets.background || currentGame.assets.banner || currentGame.assets.boxFront || currentGame.assets.marquee || currentGame.assets.poster) : (boxArt(currentGame))

        // For Steam games that lack portrait mode art
        onStatusChanged: {
            if (status == Image.Error) {
                // The funny is gone
                console.log("No Steam Game art Found.")
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

            visible: (settings["wide"] || (wideHead && index == 0)) && !settings["disableWideHeader"]

            color: "#60000000"
        }

        VideoPlayer {
            id: videoPlayer
            game: currentGame

            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            playing: settings["videoPlayback"] && doubleFocus && !isFeed
            noSound: settings["nosfx"]
        }
    }

    OpacityMask {
        id: gameItemImageRounded
        anchors.fill: gameItemImage
        source: gameItemImage
        maskSource: gameItemMask
    }



    ShaderEffectSource{
        id: shaderSource
        sourceItem: gameItemImageRounded
        width: gameItemImage.width
        height: gameItemImage.height * .2

        anchors{
            right: gameItemImage.right
            bottom: gameItemImage.bottom
        }

        sourceRect: Qt.rect(x,y, width, height)
    }

    GaussianBlur {
        id: gameItemImageBlur
        anchors.fill: shaderSource
        source: shaderSource
        radius: 32
        samples: 30

        visible: false //wide || (wideHead && index == 0)
    }

    OpacityMask {
        anchors.fill: gameItemImageBlur
        source: gameItemImageBlur
        maskSource: gameItemBlurMask
        visible: (settings["wide"] || (wideHead && index == 0)) && !settings["disableWideHeader"]
    }

    Rectangle {
        id: wideViewTextAnchor
        visible: false
        width: parent.width
        height: parent.height * .2

        anchors.bottom: parent.bottom
    }

    // Wide header text
    Text {
        id: wideViewText
        anchors.centerIn: wideViewTextAnchor
        width: parent.width * .9
        height: parent.height * .2

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        text: currentGame.title
        wrapMode: Text.WordWrap

        visible: (settings["wide"] || (wideHead && index == 0)) && !settings["disableWideHeader"]

        // The wide header is always present in the home screen at the same size;
        // to accomodate smaller wide games, scale based on height.
        font.pixelSize: height / 3.5
        font.family: gilroyLight.name
        font.bold: true

        color: "white"
        z: wideHeadBG.z + 1
    }

    // Favorite Image
    Item {
        id: favImgItem
        width: height
        height: parent.height * .15
        anchors.top: parent.top
        anchors.topMargin: parent.height * .025
        anchors.right: parent.right
        anchors.rightMargin: parent.height * .025
        z: parent.z + 5
        visible: currentGame.favorite
        Behavior on y {
            SmoothedAnimation { velocity: animVel }
        }
        Text {
            text: icons.star
            anchors.centerIn: parent
            font {
                family: icons.name;
                pixelSize: parent.height * .6
            }
            color: colors["bottomIcons"]
        }
    }

    // Drop shadow for the item
    DropShadow {
        width: parent.width
        height: parent.height

        source: gameItemTextBack

        anchors.centerIn: parent

        //visible: !plainBG
        opacity: giShadowOp

        radius: giShadowRad
        samples: giShadowRad * 2 + 1
        z: gameItemTextBack.z - 1
    }

    // Drop shadow for the favorite star
    DropShadow {
        source: favImgItem
        anchors.fill: favImgItem

        visible: favImgItem.visible
        spread: 0.35

        radius: 16
        samples: 17
        z: favImgItem.z - 1
    }



    Rectangle {
        id: gameItemMask
        anchors.fill: parent
        visible: false

        radius: settings["roundedGames"] ? height / roundedGamesRadiusFactor : 0
    }

    Rectangle {
        id: gameItemBlurMask
        anchors.fill: shaderSource
        visible: false

        radius: settings["roundedGames"] ? height / roundedGamesRadiusFactor / .2 : 0

        Rectangle {
            width: parent.width
            height: parent.height / 2

            anchors.top: parent.top
        }
    }


    // The following code used to get portrait art for steam games is from shinretro by TigraTT-Driver.

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
