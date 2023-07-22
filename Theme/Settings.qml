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
            set.clear();
            refresh_settings();
        }
    }

    // This readds all settings, with each property updated.
    function refresh_settings() {
        [
            {
                id: "light_mode",
                behavior: "toggle",
                header: loc.settings_header_appearance,
                name: loc.settings_light_mode,
                setting: "light"
            },
            {
                id: "plain_bg",
                behavior: "toggle",
                name: loc.settings_plain_bg,
                setting: "plainBG"
            },
            {
                id: "disable_buttons",
                behavior: "toggle",
                name: loc.settings_disable_buttons,
                setting: "noBtns"
            },
            {
                id: "rounded_corners",
                behavior: "toggle",
                name: loc.settings_rounded_corners,
                setting: "roundedGames"
            },
            {
                id: "center_titles",
                behavior: "toggle",
                name: loc.settings_center_titles,
                setting: "centerTitles"
            },
            {
                id: "blur_collects",
                behavior: "toggle",
                name: loc.settings_blur_collects,
                setting: "blurredCollections"
            },
            {
                id: "use_svg",
                behavior: "toggle",
                name: loc.settings_use_svg,
                setting: "useSVG",
                info: loc.settings_use_svg_info,
                is: false
            },
            {
                id: "classic_colors",
                behavior: "toggle",
                name: loc.settings_classic_colors,
                setting: "classicColors",
                info: loc.settings_classic_colors_info,
                is: false
            },



            {
                id: "wide_games",
                behavior: "toggle",
                header: loc.settings_header_interface,
                name: loc.settings_wide_games,
                setting: "wide",
                info: loc.settings_wide_games_info,
                is: false
            },
            {
                id: "games_rows",
                behavior: "set_games_rows",
                name: loc.settings_games_grid_rows,
                intprop: settings["gamesRows"]
            },
            {
                id: "collection_rows",
                behavior: "set_collection_rows",
                name: loc.settings_collection_grid_rows,
                intprop: settings["collectionRows"]
            },
            {
                id: "enlarge_bar",
                behavior: "toggle",
                name: loc.settings_enlarge_bar,
                setting: "enlargeBar",
                info: loc.settings_enlarge_bar_info,
                is: false
            },
            {
                id: "enable_clockbar",
                behavior: "toggle",
                name: loc.settings_enable_clockbar,
                setting: "useClockbar"
            },



            {
                id: "enable_touchnav",
                behavior: "toggle",
                header: loc.settings_header_behavior,
                name: loc.settings_enable_touchnav,
                setting: "mouseNav",
                info: loc.settings_enable_touchnav_info,
                is: false
            },
            {
                id: "more_recents",
                behavior: "toggle",
                name: loc.settings_more_recents,
                setting: "moreRecent",
                info: loc.settings_more_recents_info,
                is: false
            },
            {
                id: "limit_search_info",
                behavior: "toggle",
                name: loc.settings_limit_search,
                setting: "limSearch",
                info: loc.settings_limit_search_info,
                is: false
            },



            {
                id: "mute_sounds",
                behavior: "toggle",
                header: loc.settings_header_av,
                name: loc.settings_mute_sounds,
                setting: "nosfx"
            },
            {
                id: "quiet_sounds",
                behavior: "toggle",
                name: loc.settings_quiet_sounds,
                setting: "quiet"
            },
            {
                id: "video_playback",
                behavior: "toggle",
                name: loc.settings_video_playback,
                setting: "videoPlayback",
            },



            {
                id: "24h_clock",
                behavior: "toggle",
                header: loc.settings_header_localization,
                name: loc.settings_24h_clock,
                setting: "24hClock",
            },
            {
                id: "change_localization",
                behavior: "set_lang",
                name: loc.settings_change_localization,
                strprop: currentLanguage
            }
        ].forEach(function(e) { set.append(e); });
    }

    //
    // Layouts
    //

    // Title
    Text {
        id: settingsTitle
        width: parent.width * .9

        y: parent.height * 0.075

        text: loc.settings_title
        color: colors["text"]

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        // Alignment
        horizontalAlignment: settings["centerTitles"] ? Text.AlignHCenter : Text.AlignLeft

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
    }

    // Small Credits in the top right
    Text {
        id: settingsCredits

        textFormat: Text.RichText
        text: "<a style=\"text-decoration: none; color: " + colors["text"] + ";\" href=\"https://github.com/Fr75s/library\">https://github.com/Fr75s/library</a>"
        onLinkActivated: Qt.openUrlExternally(link)

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

            // doubleFocus for Settings
            readonly property bool doubleFocus: setsView.focus && isCurrentItem

            // Determines whether or not this setting contains a header
            readonly property bool isHeader: header ? true : false

            // Measurements
            readonly property real baseHeight: setsView.height / 4
            readonly property real rectMargins: doubleFocus ? 0 : vpx(10)

            width: setsView.width
            height: isHeader ? (index === 0 ? baseHeight + vpx(48) : baseHeight + vpx(96)) : baseHeight

            Item {
                anchors.fill: parent

                // Header text, shows if behavior is "header"
                Text {
                    id: settingHeader

                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.075

                    anchors.bottom: settingBoxContainer.top
                    anchors.bottomMargin: vpx(4)

                    width: parent.width * 0.6
                    height: vpx(48)

                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignTop

                    text: header ? header : ""
                    wrapMode: Text.WordWrap

                    color: colors["text"]
                    visible: isHeader

                    font.family: gilroyLight.name
                    font.bold: true
                    font.pixelSize: vpx(28)
                }

                // Header Underline
                Rectangle {
                    width: parent.width * 0.9
                    height: vpx(2)

                    anchors.top: settingHeader.bottom
                    anchors.topMargin: -1 * vpx(8)
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: colors["text"]
                    visible: isHeader
                }

                // All the other stuff
                Item {
                    id: settingBoxContainer

                    width: parent.width
                    height: baseHeight

                    anchors.bottom: parent.bottom

                    Rectangle {
                        id: settingRoot

                        color: settings["plainBG"] ? colors["plainSetting"] : colors["setting"]

                        anchors.fill: parent
                        anchors.margins: rectMargins

                        radius: height / 8

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
                            visible: !(strprop || intprop)
                        }

                        // Slider Circle
                        Rectangle {
                            width: height
                            height: baseHeight * 0.2

                            anchors.verticalCenter: parent.verticalCenter

                            x: settings[setting] ? parent.x + parent.width * 0.9 : parent.x + parent.width * 0.85

                            radius: height / 2
                            color: colors["text"]
                            visible: !(strprop || intprop)

                            Behavior on x {
                                SmoothedAnimation { duration: 100 }
                            }
                        }

                        // State Text
                        Text {
                            id: stateText
                            anchors.verticalCenter: parent.verticalCenter
                            x: parent.x + parent.width * 0.85 + parent.height * 0.1
                            width: parent.width * 0.05
                            height: parent.height

                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            text: strprop ? strprop : intprop ? intprop :""
                            wrapMode: Text.WordWrap
                            color: colors["text"]

                            font.family: gilroyLight.name
                            font.bold: true
                            font.pixelSize: parent.height * 0.15
                            font.capitalization: Font.AllUppercase
                        }

                        // Click functionality
                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                if (isCurrentItem) {
                                    changeSetting(behavior, setting);
                                    if (!settings["nosfx"])
                                        sSwitch.play();
                                } else {
                                    if (!settings["nosfx"])
                                        sNav.play();
                                    setsView.currentIndex = index;
                                }
                            }
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
		highlightResizeDuration: 200

		// Move up/down
        Keys.onUpPressed: {
            if (!settings["nosfx"]) sNav.play();

            if (currentIndex === 0) {
                currentIndex = set.count - 1;
            } else {
                decrementCurrentIndex();
            }
        }

        Keys.onDownPressed: {
            if (!settings["nosfx"]) sNav.play();

            if (currentIndex === set.count - 1) {
                currentIndex = 0;
            } else {
                incrementCurrentIndex();
            }
        }

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                return
            }

            // Change the setting with a button press
            if (api.keys.isAccept(event)) {
                if (!settings["nosfx"])
                    sSwitch.play();
                event.accepted = true;

                var selectedSetting = set.get(setsView.currentIndex);
                changeSetting(selectedSetting.behavior, selectedSetting.setting);
            }

            // Show the info: It switches the info and name properties, and toggles 'is'.
            if (api.keys.isFilters(event)) {
                event.accepted = true;
                if (set.get(setsView.currentIndex).info) {
                    if (!settings["nosfx"])
                        sSwitch.play();

                    // Swap Name & Info
                    var temp = set.get(setsView.currentIndex).name;
                    set.setProperty(setsView.currentIndex, "name", set.get(setsView.currentIndex) .info);
                    set.setProperty(setsView.currentIndex, "info", temp);

                    set.setProperty(setsView.currentIndex, "is", !set.get(setsView.currentIndex).is);
                }
            }

            if (api.keys.isDetails(event)) {
                event.accepted = true;
                if (!settings["nosfx"])
                    sNav.play();

                let j = i;
                let stopped = false;

                while (j < set.count - 1) {
                    j += 1;
                    const nextHeader = set.get(j).header
                    if (nextHeader) {
                        setsView.currentIndex = j;
                        stopped = true;
                        break;
                    }
                }

                if (!stopped && j >= set.count - 1) {
                    setsView.currentIndex = 0;
                }
            }
        }
    }

    // Changing the setting. Quite clunky, but there is little that can be done.
    function changeSetting(behavior, setting) {
        switch (behavior) {
            case "toggle":
                console.log("Toggling", setting)
                settings[setting] = !settings[setting];
                api.memory.set(setting, settings[setting]);
                break;
            case "set_lang":
                if (langs.indexOf(currentLanguage) + 1 >= langs.length)
                    currentLanguage = langs[0];
                else
                    currentLanguage = langs[langs.indexOf(currentLanguage) + 1];
                loc = localizationData.getLocalization(currentLanguage);

                api.memory.set("currentLanguage", currentLanguage);
                set.setProperty(i, "strprop", currentLanguage);
                set.clear();
                refresh_settings();
                setsView.currentIndex = i;
                break;
            case "set_games_rows":
                if (settings["gamesRows"] >= 5)
                    settings["gamesRows"] = 1;
                else
                    settings["gamesRows"] = (settings["gamesRows"] + 1);
                api.memory.set("gamesRows", settings["gamesRows"]);
                set.setProperty(i, "intprop", settings["gamesRows"]);
                break;
            case "set_collection_rows":
                if (settings["collectionRows"] >= 3)
                    settings["collectionRows"] = 1;
                else
                    settings["collectionRows"] = (settings["collectionRows"] + 1);
                api.memory.set("collectionRows", settings["collectionRows"]);
                set.setProperty(i, "intprop", settings["collectionRows"]);
                break;
        }
    }
}
