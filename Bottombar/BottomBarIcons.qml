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
    height: bottomBarSizeIndexToSize[settings["barSize"]]

    property bool limitHeight: (height > sh * 0.0525)

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
            height: limitHeight ? bottomBarSizeIndexToSize["small"] : parent.height

            spacing: parent.width * .01

            layoutDirection: Qt.RightToLeft

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: parent.width * .01

            // A Button Actions
            IconPair {
                height: parent.height * .8

                src: icons.btnScheme[settings.btnsScheme].A

                // Label for Home, Search, Collections & Settings respectively.
                // Same pattern for each IconPair.
                label: [loc.bottomBar_aSelect, (isFeed ? loc.bottomBar_aPlay : loc.bottomBar_aSelect), loc.bottomBar_aSelect, loc.bottomBar_aSetting]

                anchors.verticalCenter: parent.verticalCenter
            }

            // B Button Actions
            IconPair {
                height: parent.height * .8

                src: icons.btnScheme[settings.btnsScheme].B

                label: ["", (isFeed ? "" : loc.bottomBar_bKeyboard), loc.bottomBar_bExit, ""]

                anchors.verticalCenter: parent.verticalCenter
            }

            // Y Button Actions
            IconPair {
                height: parent.height * .8

                src: icons.btnScheme[settings.btnsScheme].Y

                label: [loc.bottomBar_yFavorite, (isFeed ? loc.bottomBar_yNext : loc.bottomBar_yKeyboard), loc.bottomBar_yFavorite, loc.bottomBar_yInfo]

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
            height: limitHeight ? bottomBarSizeIndexToSize["small"] : parent.height

            spacing: parent.width * .01

            layoutDirection: Qt.LeftToRight

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: parent.width * .01

            // L1, left blank to go with R1
            IconPair {
                height: parent.height * .8

                src: icons.btnScheme[settings.btnsScheme].L1


                label: [" ", " ", " ", " "]

                anchors.verticalCenter: parent.verticalCenter
            }

            // R1, indicating change page
            IconPair {
                height: parent.height * .8

                src: icons.btnScheme[settings.btnsScheme].R1

                label: [loc.bottomBar_changePage, loc.bottomBar_changePage, loc.bottomBar_changePage, loc.bottomBar_changePage]

                anchors.verticalCenter: parent.verticalCenter
            }

            IconPair {
                height: parent.height * .8

                src: icons.btnScheme[settings.btnsScheme].L2

                label: ["", loc.all_feed, "", ""]

                anchors.verticalCenter: parent.verticalCenter
            }

            // X Button Actions
            IconPair {
                height: parent.height * .8

                src: icons.btnScheme[settings.btnsScheme].X

                label: ["", (isFeed ? "" : loc.bottomBar_xKeyboard), "", loc.bottomBar_xNext]

                anchors.verticalCenter: parent.verticalCenter
            }

        }
    }
}
