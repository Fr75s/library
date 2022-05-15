import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import SortFilterProxyModel 0.2

import "Theme"
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

    /* The menu variable controls the current page. It is an int as it also determines the indicator's location. Here is what each value can be:
     * 0: home
     * 1: search
     * 2: collections
     * 3: settings
     */
    property int menu: 0 // 0: home; 1: all; 2: collections (submenus); 3: settings

    // Just a few fonts, needs [id].name to work in font.family
    FontLoader { id: gilroyExtraBold; source: "./assets/font/Gilroy-ExtraBold.otf" }
	FontLoader { id: gilroyLight; source: "./assets/font/Gilroy-Light.otf" }
	FontLoader { id: ralewayExtraBold; source: "./assets/font/Raleway-ExtraBold.ttf"}
	FontLoader { id: ralewayLight; source: "./assets/font/Raleway-Light.ttf" }

	// Item Specific Variables

	// Icon size of the bottom bar icons, currently 3/4 its height
	property var iconSize: bottomBar.height * .75
	// The velocity of the margin expansion animation when an item is highlighted
	property int marginAnimVel: 100

	// Radius of games' shadows
	property var giShadowRad: light ? 16 : 24
	// Opacity of games' shadows
	property var giShadowOp: 0.75

	/* OPTIONS
     * There are many options for this theme, all used in several places, but defined here for convenience.
     * These options go as follows:
     * light: Light Mode
     * plainBG: Plain (flat) Background
     * noBtns: No button indicators in the bottom bar
     * sbsl: Shows the clock bar
     * nosfx: Mutes all sound effects
     * wide: Widens all the games in GridViews
     * quiet: Quiets all sound effects
     * moreRecent: Adds more games to the recents page
     * mouseNav: Enables clickable mouse navigation icons
     * enlargeBar: Enlarges the bottom bar to touch size
     * limSearch: Limits searches so that results start with what's searched rather than containing what's searched.
     *
     * Additionally, there is a centerTitles option which centers the titles, though this is off unless you really want it.
     *
     */

    property bool light: api.memory.has("light") ? api.memory.get("light") : false
    property bool plainBG: api.memory.has("plainBG") ? api.memory.get("plainBG") : false
    property bool noBtns: api.memory.has("noBtns") ? api.memory.get("noBtns") : true
    property bool sbsl: api.memory.has("sbsl") ? api.memory.get("sbsl") : false
    property bool nosfx: api.memory.has("nosfx") ? api.memory.get("nosfx") : false
    property bool wide: api.memory.has("wide") ? api.memory.get("wide") : false
    property bool quiet: api.memory.has("quiet") ? api.memory.get("quiet") : false
    property bool moreRecent: api.memory.has("moreRecent") ? api.memory.get("moreRecent") : false
    property bool mouseNav: api.memory.has("mouseNav") ? api.memory.get("mouseNav") : true
    property bool enlargeBar: api.memory.has("enlargeBar") ? api.memory.get("enlargeBar") : false
    property bool limSearch: api.memory.has("limSearch") ? api.memory.get("limSearch") : false
    property bool useSVG: api.memory.has("useSVG") ? api.memory.get("useSVG") : false

    property bool centerTitles: false

    //
    // Layout
    //

    /* The bottomBar, showing all the icons
     *
     */
    Item {
        id: bottomBar
        height: enlargeBar ? parent.height * .1 : parent.height * .05
        width: parent.width

        anchors.bottom: parent.bottom

        Row {
            // A row of images for the bottomBar, showing each page.
            id: bbImages
            z: parent.z + 3
            spacing: parent.width * .025

            anchors.centerIn: parent

            // Note: Each iamge contains a MouseArea that changes the page to the corresponding one when clicked.
            Image { // Home
                id: bbHome
                mipmap: true
                source: useSVG ? "./assets/theme/home.svg" : "./assets/theme/home.png"
                fillMode: Image.PreserveAspectFit

                height: iconSize
                width: iconSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: {menu = 0; if (!nosfx) sTab.play();}
                }
            }

            Image { // All/Search
                id: bbAll
                mipmap: true
                source: useSVG ? "./assets/theme/search.svg" : "./assets/theme/search.png"
                fillMode: Image.PreserveAspectFit

                height: iconSize
                width: iconSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: {menu = 1; if (!nosfx) sTab.play();}
                }
            }

            Image { // Collections
                id: bbCollect
                mipmap: true
                source: useSVG ? "./assets/theme/collections.svg" : "./assets/theme/collections.png"
                fillMode: Image.PreserveAspectFit

                height: iconSize
                width: iconSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: {menu = 2; if (!nosfx) sTab.play();}
                }
            }

            Image { // Settings
                id: bbSet
                mipmap: true
                source: useSVG ? "./assets/theme/settings.svg" : "./assets/theme/settings.png"
                fillMode: Image.PreserveAspectFit

                height: iconSize
                width: iconSize

                MouseArea {
                    anchors.fill: parent
                    onClicked: {menu = 3; if (!nosfx) sTab.play();}
                }
            }
        }

        // The background for the bottom bar.
        Rectangle {
            id: bottomBarBG
            color: "black"
            opacity: plainBG ? 1 : 0.2
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
        color: "white"
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
        y: parent.height * .99

        // An animation for the movement of the indicator.
        Behavior on x {
            SmoothedAnimation { velocity: 800 }
        }
    }

    // This shows button icons, not the main icons themselves.
    BottomBarIcons {
        visible: !noBtns
    }

    // Collection converter: Not visible, but used.
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
        visible: sbsl

        z: 15
    }

    // Background

    // The background image
    Image {
        id: backgroundImage

        z: -15
        anchors.fill: parent

        source: light ? "./background-light.jpg" : "./background-dark.jpg"

        visible: !plainBG
    }

    // Background Blur

    ShaderEffectSource{
        id: shaderSource
        sourceItem: backgroundImage
        width: backgroundImage.width
        height: backgroundImage.height
        z: -14

        anchors{
            right: backgroundImage.right
            bottom: backgroundImage.bottom
        }

        sourceRect: Qt.rect(x,y, width, height)
        visible: !plainBG
    }

    GaussianBlur {
        anchors.fill: shaderSource
        z: -14

        source: shaderSource
        radius: 16
        samples: 14
        visible: !plainBG
    }

    // The background color if plain mode is on.
    Rectangle {
		id: backgroundPlain
		z: -13
		color: light ? "#FFFFFF" : "#121212"
		anchors.fill: parent

		visible: plainBG || !("./background-light.jpg" || "./background-dark.jpg")
	}

	//
	// Sounds
	//

	SoundEffect {
		id: sAccept
		source: "./assets/audio/accept.wav"
		volume: quiet ? 0.5 : 1.0
	}
	SoundEffect {
		id: sFav
		source: "./assets/audio/favorite.wav"
		volume: quiet ? 0.5 : 1.0
	}
	SoundEffect {
		id: sNav
		source: "./assets/audio/nav.wav"
		volume: quiet ? 0.5 : 1.0
	}
	SoundEffect {
		id: sBack
		source: "./assets/audio/back.wav"
		volume: quiet ? 0.5 : 1.0
	}
	SoundEffect {
		id: sTab
		source: "./assets/audio/tab.wav"
		volume: quiet ? 0.5 : 1.0
	}
	SoundEffect {
		id: sGame
		source: "./assets/audio/game.wav"
		volume: quiet ? 0.5 : 1.0
	}
	SoundEffect {
		id: sSwitch
		source: "./assets/audio/switchF.wav"
		volume: quiet ? 0.5 : 1.0
	}


	//
    // Behaviors
    //

    // Change the page if L1/R1 (LB/RB) are pressed, and loop around if necessary.
    Keys.onPressed: {
        if (api.keys.isNextPage(event)) {
            event.accepted = true;
            if (!nosfx)
                sTab.play();
            if (menu >= 3)
                menu = 0
            else
                menu++
        }
        if (api.keys.isPrevPage(event)) {
            event.accepted = true;
            if (!nosfx)
                sTab.play();
            if (menu <= 0)
                menu = 3
            else
                menu--
        }
    }

    // Launching a game
    function launchGame(game) {
        if (!nosfx)
            sGame.play();
		game.launch();
	}

}
