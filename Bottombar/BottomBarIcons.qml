import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Item {
    /* Button icons for the bottom bar
     * Shown when button indicators are enabled
     *
     */

    width: sw
    height: enlargeBar ? parent.height * .1 : parent.height * .05

    anchors.bottom: parent.bottom

    /* We define 2 items, one for the right and one for the left
     * It would be difficult to separate these.
     *
     */

    // Right Buttons
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

            // A Button Actions
            IconPair {
                height: parent.height * .8

                src: "../assets/buttons/A.svg"
                srcp: "../assets/buttons/A.png"

                // Label for Home, Search, Collections & Settings respectively.
                // Same pattern for each IconPair.
                label: ["Select", (isFeed ? "Play" : "Select"), "Select", "Change Setting"]

                anchors.verticalCenter: parent.verticalCenter
            }

            // B Button Actions
            IconPair {
                height: parent.height * .8

                src: "../assets/buttons/B.svg"
                srcp: "../assets/buttons/B.png"

                label: ["", (isFeed ? "" : "Hide Keyboard"), "Exit Collection", ""]

                anchors.verticalCenter: parent.verticalCenter
            }

            // Y Button Actions
            IconPair {
                height: parent.height * .8

                src: "../assets/buttons/Y.svg"
                srcp: "../assets/buttons/Y.png"

                label: ["Favorite", (isFeed ? "Next" : "Favorite / Space"), "Favorite", "Show Extra Info"]

                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    // Left Buttons
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

            // L1, left blank to go with R1
            IconPair {
                height: parent.height * .8

                src: "../assets/buttons/L1.svg"
                srcp: "../assets/buttons/L1.png"


                label: [" ", " ", " ", " "]

                anchors.verticalCenter: parent.verticalCenter
            }

            // R1, indicating change page
            IconPair {
                height: parent.height * .8

                src: "../assets/buttons/R1.svg"
                srcp: "../assets/buttons/R1.png"

                label: ["Change Page", "Change Page", "Change Page", "Change Page"]

                anchors.verticalCenter: parent.verticalCenter
            }

            IconPair {
                height: parent.height * .8

                src: "../assets/buttons/L2.svg"
                srcp: "../assets/buttons/L2.png"


                label: [" ", "Feed", " ", " "]

                anchors.verticalCenter: parent.verticalCenter
            }

            // X Button Actions
            IconPair {
                height: parent.height * .8

                src: "../assets/buttons/X.svg"
                srcp: "../assets/buttons/X.png"

                label: ["", (isFeed ? "" : "Keyboard / Backspace"), "", ""]

                anchors.verticalCenter: parent.verticalCenter
            }

        }
    }
}
