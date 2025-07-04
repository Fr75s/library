import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import SortFilterProxyModel 0.2

import "Theme"
import "Extra"
import "GameItems"
import "Bottombar"

FocusScope {

    //
    // Variables
    //

    id: theme

    focus: true

    // Just a shorthand for the screen width and height
    property int sw: parent.width
    property int sh: parent.height

    signal videoControl(bool pause)

    /* The menu variable controls the current page. It is an int as it also determines the indicator's location. Here is what each value can be:
     * 0: home
     * 1: search
     * 2: collections
     * 3: settings
     */
    property int menu: 0

    // Just a few fonts, needs [id].name to work in font.family
    FontLoader { id: gilroyExtraBold; source: "./assets/font/Gilroy-ExtraBold.otf" }
	FontLoader { id: gilroyLight; source: "./assets/font/Gilroy-Light.otf" }

    FontLoader { id: notoJPBold; source: "./assets/font/NotoSansJP-ExtraBold.ttf" }
	FontLoader { id: notoJPLight; source: "./assets/font/NotoSansJP-Light.ttf" }

    // Custom Font for icons
    IconFont {
        id: icons
    }

	// Item Specific Variables

	// Icon size of the bottom bar icons, currently 3/4 its height
	property var iconSize: bottomBar.height * .75
	// The velocity of the margin expansion animation when an item is highlighted
	property int marginAnimVel: 100

	// Radius of games' shadows
	property var giShadowRad: settings["light"] ? 16 : 24
	// Opacity of games' shadows
	property var giShadowOp: 0.75
	// Radius of games with rounded corners on (height / roundedGamesRadiusFactor)
	property var roundedGamesRadiusFactor: 16

	// The IsFeed option checks if the all page is the feed page, converted with L2.
	property bool isFeed: false

	/* OPTIONS
     * All options for this theme are defined here.
     * Components can refer to these options by using settings["{OPTION}"].
     */

    property var settings: {
        // Appearance Settings
        "light": api.memory.has("light") ? api.memory.get("light") : false,
        "plainBG": api.memory.has("plainBG") ? api.memory.get("plainBG") : false,
        "noBtns": api.memory.has("noBtns") ? api.memory.get("noBtns") : true,
        "btnsScheme": api.memory.has("btnsScheme") ? api.memory.get("btnsScheme") : "universal",
        "roundedGames": api.memory.has("roundedGames") ? api.memory.get("roundedGames") : false,
        "blurredCollections": api.memory.has("blurredCollections") ? api.memory.get("blurredCollections") : true,
        "disableWideHeader": api.memory.has("disableWideHeader") ? api.memory.get("disableWideHeader") : false,
        "classicColors": api.memory.has("classicColors") ? api.memory.get("classicColors") : false,
        "centerTitles": api.memory.has("centerTitles") ? api.memory.get("centerTitles") : false,
        "bgChoice": api.memory.has("bgChoice") ? api.memory.get("bgChoice") : 1,

        // Behavior Settings
        "mouseNav": api.memory.has("mouseNav") ? api.memory.get("mouseNav") : true,
        "moreRecent": api.memory.has("moreRecent") ? api.memory.get("moreRecent") : false,
        "forceHome": api.memory.has("forceHome") ? api.memory.get("forceHome") : false,
        "limSearch": api.memory.has("limSearch") ? api.memory.get("limSearch") : false, // DEPRECATED
        "searchMode": api.memory.has("searchMode") ? api.memory.get("searchMode") : "reg",

        // Audio/Video Settings
        "nosfx": api.memory.has("nosfx") ? api.memory.get("nosfx") : false,
        "quiet": api.memory.has("quiet") ? api.memory.get("quiet") : false,
        "videoPlayback": api.memory.has("videoPlayback") ? api.memory.get("videoPlayback") : false,

        // Interface Settings
        "wide": api.memory.has("wide") ? api.memory.get("wide") : false,
        "diffAspect": api.memory.has("diffAspect") ? api.memory.get("diffAspect") : false,
        "gamesRows": api.memory.has("gamesRows") ? api.memory.get("gamesRows") : 2,
        "collectionRows": api.memory.has("collectionRows") ? api.memory.get("collectionRows") : 2,         
        "enlargeBar": api.memory.has("enlargeBar") ? api.memory.get("enlargeBar") : false,
        "barSize": api.memory.has("barSize") ? api.memory.get("barSize") : "small",
        "showWideTimes": api.memory.has("showWideTimes") ? api.memory.get("showWideTimes") : false,
        "forceRecentNarrow": api.memory.has("forceRecentNarrow") ? api.memory.get("forceRecentNarrow") : false,
        "useClockbar": api.memory.has("useClockbar") ? api.memory.get("useClockbar") : false, // Formerly sbsl

        // Localization + Language
        "24hClock": api.memory.has("24hClock") ? api.memory.get("24hClock") : false,
    }

    /**
     * Option Lists
     * Used for "list" type options
     */

    // BottomBar Size

    property var bottomBarSizeOrder: {0: "tiny", 1: "small", 2: "medium", 3: "large"}
    property var bottomBarSizeConvert: {
        "tiny": loc.settings_bar_size_tiny,
        "small": loc.settings_bar_size_small,
        "medium": loc.settings_bar_size_medium,
        "large": loc.settings_bar_size_large
    }

    property var bottomBarSizeIndexToSize: {
        "tiny": parent.height * .03,
        "small": parent.height * .05,
        "medium": parent.height * .075,
        "large": parent.height * .1
    }

    // Search Mode
    property var searchModeOrder: {0: "reg", 1: "lim", 2: "fuzzy", 3: "raw"}
    property var searchModeConvert: {
        "reg": loc.settings_search_mode_regular,
        "lim": loc.settings_search_mode_limited,
        "fuzzy": loc.settings_search_mode_fuzzy,
        "raw": loc.settings_search_mode_raw
    }



    /* COLORS
     * These are the lists of colors used by this theme.
     * There are 2 default color schemes: PLANET and CLASSIC
     * Each color scheme is an object with properties containing each color
     * Use the properties for both color schemes here to make your own, or just see how these ones work.
     */

    property var colorschemes: {
        "planet": {
            "light": {
                "plainBG": "#F2F6FF", // Used as the flat background color
                "text": "#16171A", // Used as the text color
                "accent": "#74AAFF", // Used as the accent color (slider circles in settings)
                "clockBarBG": "#FFFFFF", // Used as the clock bar background color
                "barBG": "#0F1114", // Used as the bottom bar color
                "bottomIcons": "#F2F6FF", // Used as the color of the bottom bar icons
                "plainSetting": "#DEEAFF", // Used as the color of plain BG settings or alternative background color (e.g. search bar color)
                "giGradient": "#BDD5FF", // Used as the secondary color of the Game Item gradient that appears when no image is found. Set to the same as plainSetting to have no gradient on imageless gameItems
                "setting": "#30DEEAFF", // Used as the color of settings with no plain BG
                "keyboard": {
                    "bg": "#DEEAFF", // KEYBOARD: Background
                    "key": "#F2F6FF", // KEYBOARD: Key Background
                    "keyPush": "#BDD5FF", // KEYBOARD: Key Background when clicked
                    "keyHighlight": "#74AAFF", // KEYBOARD: Selected Key Highlight
                    "text": "#16171A" // KEYBOARD: Text
                }
            },
            "dark": {
                "plainBG": "#16171A",
                "text": "#F2F6FF",
                "accent": "#74AAFF",
                "clockBarBG": "#000000",
                "barBG": "#0F1114",
                "bottomIcons": "#F2F6FF",
                "plainSetting": "#26282D",
                "giGradient": "#0F1114",
                "setting": "#4016171A",
                "keyboard": {
                    "bg": "#0F1114",
                    "key": "#16171A",
                    "keyPush": "#31333A",
                    "keyHighlight": "#74AAFF",
                    "text": "#F2F6FF"
                }
            }
        },
        "classic": {
            "light": {
                "plainBG": "#FFFFFF",
                "text": "black",
                "accent": "black",
                "clockBarBG": "#DDDDDD",
                "barBG": "black",
                "bottomIcons": "white",
                "plainSetting": "#EEEEEE",
                "giGradient": "#CCCCCC",
                "setting": "#22EEEEEE",
                "keyboard": {
                    "bg": "#FFFFFF",
                    "key": "#DDDDDD",
                    "keyPush": "#BBBBBB",
                    "keyHighlight": "#steelblue",
                    "text": "#121212"
                }
            },
            "dark": {
                "plainBG": "#121212",
                "text": "white",
                "accent": "white",
                "clockBarBG": "black",
                "barBG": "black",
                "bottomIcons": "white",
                "plainSetting": "#242424",
                "giGradient": "black",
                "setting": "#33121212",
                "keyboard": {
                    "bg": "#080808",
                    "key": "#242424",
                    "keyPush": "#484848",
                    "keyHighlight": "steelblue",
                    "text": "#EEEEEE"
                }
            }
        }
    }

    // Which colors to use right now
    // MODIFICATION TIP: Replace everything after "colors:" with the address of your colorscheme to use a custom color scheme, like so: colorschemes["mycolorscheme"]["dark"]
    property var colors: settings["classicColors"] ? (settings["light"] ? colorschemes["classic"]["light"] : colorschemes["classic"]["dark"]) : (settings["light"] ? colorschemes["planet"]["light"] : colorschemes["planet"]["dark"])

    // Localization
    // Provides different languages to Library
    // Please check Localization.qml for more
    Localization {
        id: localizationData
    }

    // Get all languages
    property var langs: localizationData.getLangs()
    // Get current Language
    property string currentLanguage: api.memory.has("currentLanguage") ? api.memory.get("currentLanguage") : "en"
    // Alias for the object that is the localization's current language
    property var loc: localizationData.getLocalization(currentLanguage)


    //
    // Layout
    //

    Item {
        id: bottomBar

        height: bottomBarSizeIndexToSize[settings["barSize"]] // settings["enlargeBar"] ? parent.height * .1 : parent.height * .05
        width: parent.width

        anchors.bottom: parent.bottom

        Row {
            // A row of images for the bottomBar, showing each page.
            id: bbImages
            z: parent.z + 3
            spacing: parent.width * .025

            anchors.centerIn: parent

            // Note: Each iamge contains a MouseArea that changes the page to the corresponding one when clicked.
            Item { // Home
                id: bbHome
                height: iconSize
                width: iconSize
                Text {
                    text: icons.nav_home
                    anchors.centerIn: parent
                    font {
                        family: icons.name;
                        pixelSize: parent.height * .6
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {menu = 0; if (!settings["nosfx"]) sTab.play();}
                    }
                    color: colors["bottomIcons"]
                }
            }

            Item { // All/Search
                id: bbAll
                height: iconSize
                width: iconSize
                Text {
                    text: isFeed ? icons.nav_feed : icons.nav_search
                    anchors.centerIn: parent
                    font {
                        family: icons.name;
                        pixelSize: parent.height * .6
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {menu = 1; if (!settings["nosfx"]) sTab.play();}
                    }
                    color: colors["bottomIcons"]
                }
            }

            Item { // Collections
                id: bbCollect
                height: iconSize
                width: iconSize
                Text {
                    text: icons.nav_collections
                    anchors.centerIn: parent
                    font {
                        family: icons.name;
                        pixelSize: parent.height * .6
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {menu = 2; if (!settings["nosfx"]) sTab.play();}
                    }
                    color: colors["bottomIcons"]
                }
            }

            Item { // Settings
                id: bbSet
                height: iconSize
                width: iconSize
                Text {
                    text: icons.nav_settings
                    anchors.centerIn: parent
                    font {
                        family: icons.name;
                        pixelSize: parent.height * .6
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {menu = 3; if (!settings["nosfx"]) sTab.play();}
                    }
                    color: colors["bottomIcons"]
                }
            }
        }

        // The background for the bottom bar.
        Rectangle {
            id: bottomBarBG
            color: colors["barBG"]
            opacity: settings["plainBG"] ? 1 : 0.35
            z: parent.z

            anchors.fill: parent
        }

        // This prevents clicks from going through, so you don't click a game through the bottom bar.
        MouseArea {
            anchors.fill: parent
        }
    }

    // The indicator for the bottom bar, used to show the current page.
    Rectangle {
        id: bbIndicator
        color: colors["bottomIcons"]
        z: bottomBarBG.z + 3

        width: bbHome.width
        height: parent.height * .002

        // Hard adjust this if >4 items

        /* The current x of the indicator is set using the following formula, which works for 4 items.
         * It is first moved to the center: (parent.width / 2)
         * Then, it is moved to the left icon: - (bbImages.spacing * 1.5 + iconSize * 2)
         * Finally, it is moved right based on menu: + (menu * (iconSize + bbImages.spacing))
         *
         */
        x: (parent.width / 2) - (bbImages.spacing * 1.5 + iconSize * 2) + (menu * (iconSize + bbImages.spacing))
        y: parent.height - bottomBar.height * 0.2

        // An animation for the movement of the indicator.
        Behavior on x {
            SmoothedAnimation { velocity: 800 }
        }
    }

    // This shows button icons, not the main icons themselves.
    BottomBarIcons {
        visible: !settings["noBtns"]
    }

    // Imported from Extra/Colcon.qml
    // Used in GICusart for Custom Collection Posters
    Colcon {
        id: cc
    }

    // Home page
    // See Theme/Home.qml
    Home {
        id: home
        focus: (menu == 0)
        visible: focus
        z: bottomBar.z - 5

        width: sw
        height: sh
    }

    // Search page
    // See Theme/All.qml
    All {
        id: search
        focus: (menu == 1)
        visible: focus
        z: bottomBar.z - 5

        width: sw
        height: sh
    }

    // Collections page
    // See Theme/Collections.qml
    Collections {
        id: collects
        focus: (menu == 2)
        visible: focus
        z: bottomBar.z - 5

        width: sw
        height: sh
    }

    // Settings page
    // See Theme/Settings.qml
    Settings {
        id: sets
        focus: (menu == 3)
        visible: focus
        z: bottomBar.z - 5

        width: sw
        height: sh
    }

    // Top clock bar, visible with the setting
    // See Theme/ClockBar.qml
    ClockBar {
        id: clockbar

        /* It was originally called sbsl (Search bar search last?) because it was a search
         * bar setting, and I was too lazy to rename it.
         */
        visible: settings["useClockbar"]

        z: 15
    }

    // Background

    // The background image
    Image {
        id: backgroundImage

        z: -15
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop

        // source: settings["light"] ? "./background-light.jpg" : "./background-dark.jpg"
        source: settings["light"] ? `./assets/backgrounds/light-${settings["bgChoice"]}.jpg` : `./assets/backgrounds/dark-${settings["bgChoice"]}.jpg`

        visible: !settings["plainBG"]
    }

    // Background Blur

    ShaderEffectSource {
        id: backgroundShaderSource
        sourceItem: backgroundImage
        live: true
        width: backgroundImage.width
        height: backgroundImage.height
        z: -14

        anchors{
            right: backgroundImage.right
            bottom: backgroundImage.bottom
        }

        sourceRect: Qt.rect(x,y, width, height)
        visible: !settings["plainBG"]
    }

    GaussianBlur {
        anchors.fill: backgroundShaderSource
        z: -14

        source: backgroundShaderSource
        radius: 16
        samples: 14
        visible: !settings["plainBG"]
    }

    // The background color if plain mode is on.
    Rectangle {
		id: backgroundPlain
		z: -13
		color: colors["plainBG"]
		anchors.fill: parent

		visible: settings["plainBG"] || (backgroundImage.status == Image.Error)
	}

	//
	// Sounds
	//

	SoundEffect {
		id: sAccept
		source: "./assets/audio/accept.wav"
		volume: settings["quiet"] ? 0.5 : 1.0
	}
	SoundEffect {
		id: sFav
		source: "./assets/audio/favorite.wav"
		volume: settings["quiet"] ? 0.5 : 1.0
	}
	SoundEffect {
		id: sNav
		source: "./assets/audio/nav.wav"
		volume: settings["quiet"] ? 0.5 : 1.0
	}
	SoundEffect {
		id: sBack
		source: "./assets/audio/back.wav"
		volume: settings["quiet"] ? 0.5 : 1.0
	}
	SoundEffect {
		id: sTab
		source: "./assets/audio/tab.wav"
		volume: settings["quiet"] ? 0.5 : 1.0
	}
	SoundEffect {
		id: sGame
		source: "./assets/audio/game.wav"
		volume: settings["quiet"] ? 0.5 : 1.0
	}
	SoundEffect {
		id: sSwitch
		source: "./assets/audio/switchF.wav"
		volume: settings["quiet"] ? 0.5 : 1.0
	}
	SoundEffect {
		id: sSwitchBack
		source: "./assets/audio/switchB.wav"
		volume: settings["quiet"] ? 0.5 : 1.0
	}


	//
    // Behaviors
    //

    property bool noBackgroundsAvailable: false

    // Change the page if L1/R1 (LB/RB) are pressed, and loop around if necessary.
    Keys.onPressed: {
        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            if (!settings["nosfx"])
                sTab.play();
            if (menu >= 3)
                menu = 0
            else
                menu++

            if (menu == 1)
                theme.videoControl(false)
            else
                theme.videoControl(true)
        }
        if (api.keys.isPrevPage(event)) {
            event.accepted = true;
            if (!settings["nosfx"])
                sTab.play();
            if (menu <= 0)
                menu = 3
            else
                menu--

            if (menu == 1)
                theme.videoControl(false)
            else
                theme.videoControl(true)
        }
    }

    // Launching a game
    function launchGame(game) {
        if (!settings["nosfx"])
            sGame.play();
        // Save which menu we were on
        api.memory.set("tempSavedMenu", menu);
        // Launch the game
		game.launch();
	}

	// Get cell width based on aspect ratio
	function getCellWidth(cellHeight, enableWide) {
        if (enableWide) {
            if (settings["diffAspect"]) {
                return settings["wide"] ? (cellHeight * (16/9)) : (cellHeight * (3/4));
            } else {
                return settings["wide"] ? (cellHeight * (92/43)) : (cellHeight * (2/3));
            }
        } else {
            return settings["diffAspect"] ? (cellHeight * (3/4)) : (cellHeight * (2/3))
        }
    }



    // On Load
    Component.onCompleted: {
        console.log("Welcome to Library!");
        if (api.memory.has("tempSavedMenu")) {
            if (!settings["forceHome"]) {
                backToTimer.start();
            } else {
                api.memory.unset("tempSavedMenu");
            }
        }
    }

    Timer {
        id: backToTimer

        interval: 100
		repeat: false
		running: false

		onTriggered: {
            menu = api.memory.get("tempSavedMenu");
            api.memory.unset("tempSavedMenu");
        }
    }

}
