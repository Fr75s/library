import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import SortFilterProxyModel 0.2


FocusScope {
    id: sets

    // A very quick thing for the changeSetting function.
    property int i: setsView.currentIndex

    // Settings Model
    ListModel {
        id: set

        // We don't set these as ListElement items as setting the setting property to what it is breaks everything.
        Component.onCompleted: {
            [
                {
                    name: "Light Mode",
                    setting: light
                },
                {
                    name: "Plain Background",
                    setting: plainBG
                },
                {
                    name: "Disable Button Prompts",
                    setting: noBtns
                },
                {
                    name: "Rounded Games",
                    setting: roundedGames
                },
                {
                    name: "Enable Clock",
                    setting: sbsl
                },
                {
                    name: "Wide Games View",
                    setting: wide,
                    info: "Increases the width of the game art shown.",
                    is: false
                },
                {
                    name: "Enable Touch Navigation Icons",
                    setting: mouseNav,
                    info: "Adds arrows on the top right of certain game grids to allow you to go back if you're using a touch-based device or mouse.",
                    is: false
                },
                {
                    name: "More Recent Games Shown",
                    setting: moreRecent,
                    info: "Increases the number of games on the recent list from 8 to 16.",
                    is: false
                },
                {
                    name: "Limit Search to Starting Characters",
                    setting: limSearch,
                    info: "Makes it so that searches search for games that start with the text searched, not games that contain the text searched (both in their titles)",
                    is: false
                },
                {
                    name: "Enlarge Bottom Bar",
                    setting: enlargeBar,
                    info: "Doubles the size of the bottom bar for easier mouse/touch navigation.",
                    is: false
                },
                {
                    name: "Use SVG Icons",
                    setting: useSVG,
                    info: "Allows you to use higher quality SVG icons rather than PNG icons. Higher quality on very large screens, but may break images on some devices.",
                    is: false
                },
                {
                    name: "Use Classic Colorscheme",
                    setting: classicColors,
                    info: "Reverts the colors of the UI back to the colors used in Library prior to version 1.2.0.",
                    is: false
                },
                {
                    name: "Quiet Sound Effects",
                    setting: quiet
                },
                {
                    name: "Mute Sound Effects",
                    setting: nosfx
                }
            ].forEach(function(e) { append(e); });
        }

        /*
        ListElement {
            name: "Light Mode"
            setting: true
        }
        ListElement {
            name: "Plain Background"
            setting: false
        }
        ListElement {
            name: "Disable Button Prompts"
            setting: true
        }
        ListElement {
            name: "Visible Top Bar"
            setting: true
        }
        ListElement {
            name: "Wide Games View"
            setting: true
        }
        ListElement {
            name: "No Sound Effects"
            setting: true
        }
        */
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
        color: colors["text"]

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        // Alignment
        horizontalAlignment: centerTitles ? Text.AlignHCenter : Text.AlignLeft

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
    }

    // Small Credits in the top right
    Text {
        id: settingsCredits

        text: "https://github.com/Fr75s/library"
        color: colors["text"]

        width: parent.width * 0.95
		anchors.horizontalCenter: parent.horizontalCenter
		height: parent.height * 0.035

		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter

		font.family: gilroyLight.name
		font.pixelSize: height / 2

        z: 18
    }

    // Settings view to show the set model
    ListView {
        id: setsView
        width: parent.width * 0.9
        height: parent.height * 0.8 //* (Math.ceil(api.allGames.count / 6))

        anchors.top: parent.top
        anchors.topMargin: parent.height * .15

        model: set
        delegate: Item {
            // Custom setting delegate
            readonly property bool isCurrentItem: ListView.isCurrentItem
            // The last doubleFocus
            readonly property bool doubleFocus: setsView.focus && isCurrentItem

            width: setsView.width
            height: setsView.height / 4

            Rectangle {
                id: settingRoot
                color: plainBG ? colors["plainSetting"] : colors["setting"]
                anchors.fill: parent

                radius: height / 8

                anchors.margins: doubleFocus ? 0 : vpx(10)

                Behavior on anchors.margins {
                    SmoothedAnimation { velocity: marginAnimVel }
                }

                // Setting name, shows info if it exists
                Text {
                    id: settingText
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.1
                    width: parent.width * 0.6
                    height: parent.height

                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter

                    text: name
                    wrapMode: Text.WordWrap

                    color: colors["text"]

                    font.family: gilroyLight.name
                    font.bold: true
                    font.pixelSize: is ? vpx(16) : vpx(28)
                }

                // Information indicator
                Rectangle {
                    width: height
                    height: vpx(32)

                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.045
                    anchors.verticalCenter: parent.verticalCenter

                    color: colors["text"]
                    radius: height / 2
                    visible: info ? true : false

                    Text {
                        anchors.fill: parent

                        text: "i"
                        color: colors["plainBG"]
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: vpx(16)
                    }
                }


                // Slider bar
                Rectangle {
                    width: parent.width * 0.05
                    height: vpx(2)

                    anchors.verticalCenter: parent.verticalCenter
                    x: parent.x + parent.width * 0.85 + parent.height * 0.1
                    color: colors["text"]
                }

                // Slider Circle
                Rectangle {
                    width: height
                    height: parent.height * 0.2

                    anchors.verticalCenter: parent.verticalCenter
                    x: setting ? parent.x + parent.width * 0.9 : parent.x + parent.width * 0.85
                    radius: height / 2
                    color: colors["text"]

                    Behavior on x {
                        SmoothedAnimation { velocity: 800 }
                    }
                }

                // Click functionality
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

        highlightMoveDuration: 200
		highlightResizeDuration: 0

		// Move up/down
        Keys.onUpPressed: {
            if (!nosfx) sNav.play();
            decrementCurrentIndex();
        }
        Keys.onDownPressed: {
            if (!nosfx) sNav.play();
            incrementCurrentIndex();
        }

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                return
            }

            // Change the setting with a button press
            if (api.keys.isAccept(event)) {
                if (!nosfx)
                    sSwitch.play();
                event.accepted = true;
                changeSetting()
            }

            // Show the info: It switches the info and name properties, and toggles 'is'.
            if (api.keys.isFilters(event)) {
                event.accepted = true;
                if (set.get(setsView.currentIndex).info) {
                    if (!nosfx)
                        sSwitch.play();
                    var temp = set.get(setsView.currentIndex).name
                    set.setProperty(setsView.currentIndex, "name", set.get(setsView.currentIndex) .info)
                    set.setProperty(setsView.currentIndex, "info", temp)
                    set.setProperty(setsView.currentIndex, "is", !set.get(setsView.currentIndex).is)
                }
            }
        }
    }

    // Changing the setting. Quite clunky, but there is little that can be done.
    function changeSetting() {
        switch (i) {
            case 0:
                light = !light;
                api.memory.set("light", light);
                set.setProperty(0, "setting", light);
                break;
            case 1:
                plainBG = !plainBG
                api.memory.set("plainBG", plainBG);
                set.setProperty(1, "setting", plainBG);
                break;
            case 2:
                noBtns = !noBtns
                api.memory.set("noBtns", noBtns);
                set.setProperty(2, "setting", noBtns);
                break;
            case 3:
                roundedGames = !roundedGames
                api.memory.set("roundedGames", roundedGames);
                set.setProperty(3, "setting", roundedGames);
                break;
            case 4:
                sbsl = !sbsl
                api.memory.set("sbsl", sbsl);
                set.setProperty(4, "setting", sbsl);
                break;
            case 5:
                wide = !wide
                api.memory.set("wide", wide);
                set.setProperty(5, "setting", wide);
                break;
            case 6:
                mouseNav = !mouseNav
                api.memory.set("mouseNav", mouseNav);
                set.setProperty(6, "setting", mouseNav);
                break;
            case 7:
                moreRecent = !moreRecent
                api.memory.set("moreRecent", moreRecent);
                set.setProperty(7, "setting", moreRecent);
                break;
            case 8:
                limSearch = !limSearch
                api.memory.set("limSearch", limSearch);
                set.setProperty(8, "setting", limSearch);
                break;
            case 9:
                enlargeBar = !enlargeBar
                api.memory.set("enlargeBar", enlargeBar);
                set.setProperty(9, "setting", enlargeBar);
                break;
            case 10:
                useSVG = !useSVG
                api.memory.set("useSVG", useSVG);
                set.setProperty(10, "setting", useSVG);
                break;
            case 11:
                classicColors = !classicColors
                api.memory.set("classicColors", classicColors);
                set.setProperty(11, "setting", classicColors);
                break;
            case 12:
                quiet = !quiet
                api.memory.set("quiet", quiet);
                set.setProperty(12, "setting", quiet);
                break;
            case 13:
                nosfx = !nosfx
                api.memory.set("nosfx", nosfx);
                set.setProperty(13, "setting", nosfx);
                break;
        }
    }

}
