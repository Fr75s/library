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

    /*
     * SETTING OBJECT FIELDS:
     *
     * id: The ID of the setting (currently unused).
     * behavior: The Behavior of the setting, which can be one of the following:
     *     GENERIC
     *     "toggle": The setting is a simple toggle, used for boolean settings.
     *     "list": The setting goes through one of several items in a predefined list, used for
     *             settings with more than two options.
     *     "counter": The setting can be set to any value from 1 to maxValue, used
     *                for numerical settings.
     *     SPECIAL
     *     "sp_change_bg": Goes through the filesystem to change the background.
     *     "sp_change_lang": Changes language, but also refreshes the UI.
     * name: The displayed Name of the setting.
     * setting: The actual setting identifier, defined in the settings object in theme.qml and
     *          referred to by other Components.
     * header: Marks this setting as the header of a section with the name given by the
     *         value of header, used for the first setting in each section.
     * info: Additional information for a setting. Requires `is` to be defined.
     * is: The state to determine whether or not additional information is shown for a setting.
     *     Will always be defined as false.
     * intprop: The displayed number value for a "counter" setting
     * strprop: The displayed value for a "list" setting
     * capitalizationMode: The capitalization of the value in strprop
     */

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
                id: "disable_wide_header",
                behavior: "toggle",
                name: loc.settings_disable_wide_header,
                setting: "disableWideHeader"
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
                id: "change_bg",
                behavior: "sp_change_bg",
                name: loc.settings_change_bg,
                setting: "bgChoice",
                intprop: settings["bgChoice"]
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
                id: "diff_aspect",
                behavior: "toggle",
                name: loc.settings_diff_aspect,
                setting: "diffAspect",
                info: loc.settings_diff_aspect_info,
                is: false
            },
            {
                id: "disable_buttons",
                behavior: "toggle",
                name: loc.settings_disable_buttons,
                setting: "noBtns"
            },
            {
                id: "button_scheme",
                behavior: "list",
                name: loc.settings_button_scheme,
                setting: "btnsScheme",
                order: icons.btnSchemeOrder,
                displayConvert: icons.btnNameConvert,
                strprop: icons.btnNameConvert[settings["btnsScheme"]],
                capitalizationMode: Font.Capitalize
            },
            {
                id: "games_rows",
                behavior: "counter",
                maxValue: 5,
                name: loc.settings_games_grid_rows,
                setting: "gamesRows",
                intprop: settings["gamesRows"]
            },
            {
                id: "collection_rows",
                behavior: "counter",
                maxValue: 3,
                name: loc.settings_collection_grid_rows,
                setting: "collectionRows",
                intprop: settings["collectionRows"]
            },
            {
                id: "show_wide_times",
                behavior: "toggle",
                name: loc.settings_show_wide_times,
                setting: "showWideTimes"
            },
            {
                id: "force_recent_narrow",
                behavior: "toggle",
                name: loc.settings_force_recent_narrow,
                setting: "forceRecentNarrow",
                info: loc.settings_force_recent_narrow_info,
                is: false
            },
            {
                id: "enlarge_bar",
                behavior: "list",
                name: loc.settings_enlarge_bar,
                setting: "barSize",
                order: bottomBarSizeOrder,
                displayConvert: bottomBarSizeConvert,
                strprop: bottomBarSizeConvert[settings["barSize"]],
                capitalizationMode: Font.Capitalize
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
            /* Limited Search has been DEPRECATED in favor of Search Mode
            {
                id: "limit_search_info",
                behavior: "toggle",
                name: loc.settings_limit_search,
                setting: "limSearch",
                info: loc.settings_limit_search_info,
                is: false
            },
            */
            {
                id: "search_mode",
                behavior: "list",
                name: loc.settings_search_mode,
                setting: "searchMode",
                order: searchModeOrder,
                displayConvert: searchModeConvert,
                strprop: searchModeConvert[settings["searchMode"]],
                capitalizationMode: Font.Capitalize,
                info: loc.settings_search_mode_info,
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
                behavior: "sp_set_lang",
                name: loc.settings_change_localization,
                strprop: currentLanguage,
                capitalizationMode: Font.AllUppercase
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
                            font.capitalization: capitalizationMode ? capitalizationMode : Font.AllUppercase
                        }

                        // Click functionality
                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                if (isCurrentItem) {
                                    if (behavior === "counter") {
                                        changeSetting(behavior, setting, maxValue);
                                    } else {
                                        changeSetting(behavior, setting);
                                    }
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
                event.accepted = true;

                var selectedSetting = set.get(setsView.currentIndex);

                if (!settings["nosfx"])
                    if (selectedSetting.behavior !== "toggle" || !settings[selectedSetting.setting])
                        sSwitch.play();
                    else
                        sSwitchBack.play();

                if (selectedSetting.behavior === "counter") {
                    changeSetting(selectedSetting.behavior, selectedSetting.setting, selectedSetting.maxValue);
                } else {
                    changeSetting(selectedSetting.behavior, selectedSetting.setting);
                }
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
    function changeSetting(behavior, setting, maxValue = 5) {
        switch (behavior) {
            // Generic Behaviors
            case "toggle":
                console.log("Toggling", setting);
                settings[setting] = !settings[setting];
                api.memory.set(setting, settings[setting]);

                // Special Case: Update background on light/dark mode
                if (setting === "light") {
                    backgroundImage.source = settings["light"] ? `../assets/backgrounds/light-${settings["bgChoice"]}.jpg` : `../assets/backgrounds/dark-${settings["bgChoice"]}.jpg`
                }

                break;
            case "counter":
                console.log("Incrementing", setting);
                if (settings[setting] >= maxValue)
                    settings[setting] = 1;
                else
                    settings[setting] = (settings[setting] + 1);
                api.memory.set(setting, settings[setting]);
                set.setProperty(i, "intprop", settings[setting]);
                break;
            case "list":
                console.log("Changing", setting);
                var settingConv = set.get(i).displayConvert;
                var settingList = set.get(i).order;

                var index = Object.values(settingList).indexOf(settings[setting]);
                var newObj;
                if (index >= Object.keys(settingList).length - 1) {
                    newObj = settingList[0];
                } else {
                    newObj = settingList[index + 1];
                }
                console.log(setting, "is now", newObj);

                api.memory.set(setting, newObj);
                set.setProperty(i, "strprop", settingConv[newObj]);
                break;

            // Special Behaviors
            case "sp_set_lang":
                // Get the next language
                if (langs.indexOf(currentLanguage) + 1 >= langs.length)
                    currentLanguage = langs[0];
                else
                    currentLanguage = langs[langs.indexOf(currentLanguage) + 1];
                // Set the localization data
                loc = localizationData.getLocalization(currentLanguage);

                console.log("Setting Language to", currentLanguage);

                // Set the current language property
                api.memory.set("currentLanguage", currentLanguage);
                set.setProperty(i, "strprop", currentLanguage);
                // Refresh the settings page to immediately apply language
                set.clear();
                refresh_settings();
                setsView.currentIndex = i;
                break;
            case "sp_change_bg":
                console.log("Attempting to Increment Background");

                // Don't do anything if we're not loading
                if ((bgCheckImage.status == Image.Ready || bgCheckImage.status == Image.Error)) {
                    validDarkBG = false;
                    validBG = false;

                    bgCheckNumber += 1;
                    bgChangeSettingIndex = i;

                    bgCheckImage.source = `../assets/backgrounds/dark-${bgCheckNumber}.jpg`;
                }

                break;
        }
    }

    // For Background image validity checks
    property int bgCheckNumber: settings["bgChoice"]
    property int bgChangeSettingIndex: 1

    property bool validDarkBG: false
    property bool validBG: false

    Image {
        id: bgCheckImage
        visible: false
        //z: -10
        source: `../assets/backgrounds/dark-${bgCheckNumber}.jpg`

        onStatusChanged: {
            //console.log(`STATUS (${source}): ${bgCheckImage.status}`);
            if (bgCheckImage.status == Image.Ready) {
                if (!validDarkBG) {
                    console.log(`Checking Light Mode... (${bgCheckNumber})`);
                    validDarkBG = true;
                    source = `../assets/backgrounds/light-${bgCheckNumber}.jpg`
                } else {
                    console.log(`Background Index is valid! (${bgCheckNumber})`);
                    validBG = true;
                    setBgTo(bgCheckNumber);
                }
            }
            if (bgCheckImage.status == Image.Error) {
                validDarkBG = false;
                validBG = false;
                if (bgCheckNumber > 1) {
                    console.log("Final background reached, going back...");
                    bgCheckNumber = 1;
                    source = `../assets/backgrounds/dark-${bgCheckNumber}.jpg`
                } else {
                    // No backgrounds available
                    console.log("No backgrounds available at all.");
                    noBackgroundsAvailable = true;
                }
            }
        }
    }

    function setBgTo(index) {
        console.log("Changing to background", index);

        settings["bgChoice"] = index;
        api.memory.set("bgChoice", index);
        set.setProperty(bgChangeSettingIndex, "intprop", index);

        backgroundImage.source = settings["light"] ? `../assets/backgrounds/light-${settings["bgChoice"]}.jpg` : `../assets/backgrounds/dark-${settings["bgChoice"]}.jpg`

        console.log(`Background Image Source is now ${backgroundImage.source}`);
    }
}
