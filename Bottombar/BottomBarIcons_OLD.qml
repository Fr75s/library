import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Item {
    width: sw
    height: parent.height * .05

    anchors.bottom: parent.bottom

    Item {
        width: parent.width / 2
        height: parent.height

        anchors.bottom: parent.bottom
        anchors.right: parent.right

        // Right Row
        Row {
            id: rightRow

            width: parent.width
            height: parent.height

            spacing: parent.width * .01

            layoutDirection: Qt.RightToLeft

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: parent.width * .01

            Text {
                width: sw / 16
                height: parent.height

                color: "white"
                text: "Select"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: vpx(16)
                font.family: gilroyLight.name
                font.bold: true
            }

            Rectangle {
                width: height
                height: parent.height * .65

                anchors.verticalCenter: parent.verticalCenter

                color: "white"
                radius: (width / 2)

                Text {
                    anchors.fill: parent

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "black"
                    text: "A"
                    font.pixelSize: vpx(16)
                    font.family: gilroyLight.name
                    font.bold: true
                }
            }

            Text {
                width: sw / 16
                height: parent.height

                color: "white"
                text: "Favorite"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: vpx(16)
                font.family: gilroyLight.name
                font.bold: true

                visible: !((menu == 0 && focused == 1) || (menu == 2 && !gameView) || (menu == 3))
            }

            Rectangle {
                width: height
                height: parent.height * .65

                anchors.verticalCenter: parent.verticalCenter

                color: "white"
                radius: (width / 2)

                visible: !((menu == 0 && focused == 1) || (menu == 2 && !gameView) || (menu == 3))

                Text {
                    anchors.fill: parent

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "black"
                    text: "Y"
                    font.pixelSize: vpx(16)
                    font.family: gilroyLight.name
                    font.bold: true
                }
            }
        }
    }

    Item {
        width: parent.width / 2
        height: parent.height

        anchors.bottom: parent.bottom
        anchors.left: parent.left

        // Left Row
        Row {
            id: leftRow

            width: parent.width
            height: parent.height

            spacing: parent.width * .01

            layoutDirection: Qt.LeftToRight

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.width * .01

            Rectangle {
                width: height
                height: parent.height * .65

                anchors.verticalCenter: parent.verticalCenter

                color: "white"
                radius: (width / 8)

                Text {
                    anchors.fill: parent

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "black"
                    text: "L"
                    font.pixelSize: vpx(16)
                    font.family: gilroyLight.name
                    font.bold: true
                }
            }

            Rectangle {
                width: height
                height: parent.height * .65

                anchors.verticalCenter: parent.verticalCenter

                color: "white"
                radius: (width / 8)

                Text {
                    anchors.fill: parent

                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    color: "black"
                    text: "R"
                    font.pixelSize: vpx(16)
                    font.family: gilroyLight.name
                    font.bold: true
                }
            }

            Text {
                width: sw / 12
                height: parent.height

                color: "white"
                text: "Change Page"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.pixelSize: vpx(16)
                font.family: gilroyLight.name
                font.bold: true
            }
        }
    }
}
