import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import SortFilterProxyModel 0.2


FocusScope {
    id: sets

    /*
     * Old Grid View Settings, don't use
     *
     */

    property int i: setsView.currentIndex

    // Settings Model

    ListModel {
        id: settings

        ListElement {
            name: "Light Mode"
        }
        ListElement {
            name: "Plain Background"
        }
        ListElement {
            name: "Disable Button Prompts"
        }
        ListElement {
            name: "Visible Top Bar"
        }
        ListElement {
            name: "Wide Games View"
        }
        ListElement {
            name: "No Sound Effects"
        }
    }

    //
    // Layouts
    //

    // Title
    Text {
        id: settingsTitle
        width: parent.width * .9

        y: parent.height * 0.075

        text: "Settings"
        color: light ? "black" : "white"

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        // Alignment
        horizontalAlignment: centerTitles ? Text.AlignHCenter : Text.AlignLeft

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
    }

    Text {
        id: settingsCredits

        text: "UI By Fr75s"
        color: light ? "black" : "white"

        width: parent.width * 0.95
		anchors.horizontalCenter: parent.horizontalCenter
		height: parent.height * 0.035

		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter

		font.family: gilroyLight.name
		font.pixelSize: height / 2

        z: 18
    }

    GridView {
        id: setsView
        width: parent.width * 0.9
        height: parent.height * 0.8 //* (Math.ceil(api.allGames.count / 6))

        anchors.top: parent.top
        anchors.topMargin: parent.height * .15

        cellWidth: width / 3
        cellHeight: height / 2 /// (Math.ceil(api.allGames.count / 6))

        //currentIndex: 0
        model: settings

        delegate: Item {
            readonly property bool isCurrentItem: GridView.isCurrentItem
            readonly property bool doubleFocus: setsView.focus && isCurrentItem

            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Rectangle {
                color: plainBG ? (light ? "#EEEEEE" : "#242424") : (light ? "#22EEEEEE" : "#33121212")
                anchors.fill: parent

                anchors.margins: doubleFocus ? 0 : vpx(10)

                Behavior on anchors.margins {
                    SmoothedAnimation { velocity: marginAnimVel }
                }

                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    text: name
                    wrapMode: Text.WordWrap

                    color: light ? "black" : "white"

                    font.family: gilroyLight.name
                    font.bold: true
                    font.pixelSize: vpx(16)
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (isCurrentItem) {
                            changeSetting();
                            if (!nosfx)
                                sSwitch.play();
                        } else {
                            if (!nosfx)
                                sNav.play();
                            setsView.currentIndex = index;
                        }
                    }
                }
            }
        }

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        clip: true
        focus: (menu == 3)

        Keys.onUpPressed: { if (!nosfx) sNav.play(); moveCurrentIndexUp() }
        Keys.onDownPressed: { if (!nosfx) sNav.play(); moveCurrentIndexDown() }
        Keys.onLeftPressed: { if (!nosfx) sNav.play(); moveCurrentIndexLeft() }
        Keys.onRightPressed: { if (!nosfx) sNav.play(); moveCurrentIndexRight() }

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                return
            }

            if (api.keys.isAccept(event)) {
                if (!nosfx)
                    sSwitch.play();
                event.accepted = true;
                changeSetting()
            }
        }
    }

    function changeSetting() {
        switch (i) {
            case 0:
                light = !light;
                api.memory.set("light", light);
                break;
            case 1:
                plainBG = !plainBG
                api.memory.set("plainBG", plainBG);
                break;
            case 2:
                noButtons = !noButtons
                api.memory.set("noButtons", noButtons);
                break;
            case 3:
                sbsl = !sbsl
                api.memory.set("sbsl", sbsl);
                break;
            case 4:
                wide = !wide
                api.memory.set("wide", wide);
                break;
            case 5:
                nosfx = !nosfx
                api.memory.set("nosfx", nosfx);
                break;
        }
    }

}
