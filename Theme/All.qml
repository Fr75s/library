import QtQuick 2.15
import QtMultimedia 5.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import SortFilterProxyModel 0.2

import "../GameItems"
import "PegaKey"

/*
 *
 * Note
 * This may be called all, but this has been revitalized to a search
 *
 */

FocusScope {
    id: search

    property bool feed: false
    property bool searching: false

    // Converts the text in searchInput to a regex pattern
    function searchInputConvert(inputText) {
        if (settings["searchMode"] === "raw") {
            return inputText;
        } else {
            const specialSymbols = ["^", "$", "\\", ".", "*", "+", "?", "(", ")", "[", "]", "{", "}", "|", "/"];
            const capitals = /[A-Z]/g;

            if (settings["searchMode"] === "fuzzy") {
                let outputStr = "";
                for (let i = 0; i < inputText.length; i++) {
                    if (inputText[i].match(capitals)) {
                        // Make next letter match require to start at next word
                        outputStr += "\\b" + inputText[i];
                    } else if (specialSymbols.includes(inputText[i])) {
                        // Escape special character
                        outputStr += "\\" + inputText[i];
                    } else {
                        outputStr += inputText[i];
                    }
                    // Loose Matching
                    outputStr += ".*";
                }
                console.log(JSON.stringify(outputStr));
                return outputStr;
            } else {
                // Escape special symbols
                let regexCleanText = inputText.split("");
                for (let i = regexCleanText.length - 1; i >= 0; i--) {
                    if (specialSymbols.includes(regexCleanText[i])) {
                        regexCleanText.splice(i, 0, "\\");
                    }
                }
                let outputStr = "";
                for (let i = 0; i < regexCleanText.length; i++) {
                    outputStr += regexCleanText[i];
                }

                // Add ^ to beginning of pattern if limited search
                if (settings["searchMode"] === "lim") {
                    outputStr = "^" + outputStr;
                }
                return outputStr;
            }
        }
    }

    // Define Current Game
    SortFilterProxyModel {
        id: searchSort
        sourceModel: api.allGames

        // The searching functionality for the model
        filters: RegExpFilter {
            roleName: "title";
            // Limited search matches ^[term] rather than [term]
            pattern: searchInputConvert(searchInput.text);
            enabled: searchInput.text != "";
            caseSensitivity: Qt.CaseInsensitive;
        }
    }

    /*
     * Note: The bug pertaining to not being able to run or favorite games when searching was fixed
     * by changing searchSort.get(allView.currentIndex) to api.allGames.get(searchSort.mapToSource(allView.currentIndex)).
     * This fix is from clearOS.
     *
     */

    // The current game
    property var currentGameIndex: {
        if (searchSort.count == 0 || searchSort.count == api.allGames.count)
            return allView.currentIndex;
        else
            return searchSort.mapToSource(allView.currentIndex);
    }
    property var current: {
        return api.allGames.get(currentGameIndex);
    }
    property var feedCurrent

    //
    // Layouts
    //

    // Title
    Text {
        id: allTitle
        width: parent.width * .9

        y: parent.height * 0.075

        text: feed ? loc.all_feed : loc.all_search
        color: colors["text"]

        // Alignment
        horizontalAlignment: Text.AlignLeft

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
    }



    // Search Background, to indicate it is a search field
    // (outside of searchInput to prevent bug where searchInput text is under the bg)
    Rectangle {
        id: searchInputBG

        width: searchInput.width + (searchInput.height * .5)
        height: searchInput.height * 1.2
        anchors.centerIn: searchInput

        radius: height * .25
        visible: !feed

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: colors["plainSetting"] }
            GradientStop { position: 1.0; color: colors["plainBG"] }
        }

        // Highlight when searching
        Rectangle {
            anchors.fill: parent
            radius: parent.radius

            visible: (menu == 1) && !(allView.focus)

            border.color: colors["accent"]
            border.width: 2
            color: "transparent"
        }
    }

    DropShadow {
        anchors.fill: searchInputBG
        source: searchInputBG

        visible: !settings["plainBG"] && !feed
        opacity: giShadowOp

        radius: giShadowRad
        samples: giShadowRad * 2 + 1
        z: searchInputBG.z - 1
    }

    // Search text input, used for searching
    // Its text property is what is used for searching
    TextInput {
        id: searchInput
        width: parent.width * .6
        height: parent.height * .06

        visible: !feed
        focus: false

        y: parent.height * 0.075

        color: colors["text"]

        // Alignment
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        selectByMouse: true;

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        // Indicator for the word, used to show the end of the text
        Rectangle {
            width: 1
            height: parent.height

            anchors.left: parent.left
            anchors.leftMargin: parent.contentWidth

            visible: (menu == 1) && !(allView.focus)
        }

        // Click control, invokes keyboard
        MouseArea {
            anchors.fill: parent

            onClicked: {
                keys.invokeNoFocus();
                parent.focus = true;
                searching = true;
            }
        }

        Keys.onEscapePressed: {
            keys.hide();
        }

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                return
            }

            if (api.keys.isAccept(event)) {
                event.accepted = true;
                keys.hide();
            }
        }
    }

    /* The special keyboard implementation, instantiated here
     * This is the main way an actual implementation of this is shown.
     * The keyboard's functionality can be found by looking at the files in the PegaKey folder.
     *
     */
    Keyboard {
        id: keys

        // Width and height are defined in the keyboard
        anchors.fill: parent
        z: 20

        kcolors: colors["keyboard"]

        sfxSource: ".././assets/audio/type.wav"
        quietSfx: settings["quiet"];
        muteSfx: settings["nosfx"];

        // Adds key to input, unless it's a backspace or clear
        onSendKey: {
            if (text == "bksp") {
                if (searchInput.text.length > 0) {
                    searchInput.text = searchInput.text.substring(0, searchInput.text.length - 1)
                }
            } else if (text == "CLEAR") {
                searchInput.text = ""
            } else {
                searchInput.text = searchInput.text + text;
                searchInput.forceLayout()
            }
        }

        // Invoke provides more functionality in the keyboard itself.
        onInvoked: {
            searching = true;
        }

        // More functionality is in the keyboard itself.
        // It also focuses the game view.
        onDone: {
            searching = false;
            allView.focus = (menu == 1) && !searching;
        }
    }

    // All View
    // See all games or searched games
    GridView {
        id: allView
        width: settings["wide"] ? height * (2.14) : height * (2)
        height: settings["wide"] ? parent.height * 0.7 : parent.height * 0.75 //* (Math.ceil(api.allGames.count / 6))

        // Rectangle {
        //     anchors.fill: parent
        //     opacity: 0.1
        // }

        anchors.top: parent.top
        anchors.topMargin: parent.height * .175
        anchors.horizontalCenter: parent.horizontalCenter

        visible: !feed

        // Grid
        cellWidth: getCellWidth(cellHeight, true)//settings["wide"] ? (cellHeight * (92/43)) : (cellHeight * (2/3))
        cellHeight: height / settings["gamesRows"]

        // Sets the model to everything if the search is empty or contains all games
        model: (searchSort.count == 0 || searchSort.count == api.allGames.count) ? api.allGames : searchSort

        delegate: Item {
            readonly property bool isCurrentItem: GridView.isCurrentItem
            // Once again, double focus indicates this game is selected
            readonly property bool doubleFocus: allView.focus && isCurrentItem

            width: GridView.view.cellWidth
            height: GridView.view.cellHeight

            Item {
                anchors {
                    fill: parent
                    margins: (doubleFocus) ? 0 : vpx(10)
                }

                Behavior on anchors.margins {
                    SmoothedAnimation { velocity: marginAnimVel }
                }

                GINormal { }

                /*
                Loader {
                    anchors.fill: parent
                    asynchronous: true
                    sourceComponent: GINormal { }
                    active: all.focus
                    visible: status === Loader.Ready
                }
                */

                // Click functionality
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (isCurrentItem) {
                            launchGame(modelData)
                        }
                        else {
                            allView.currentIndex = index
                            if (!settings["nosfx"])
                                sNav.play();
                            if (searching)
                                searching = false
                        }
                    }
                }
            }


        }

        clip: true
        focus: (menu == 1) && !searching

        // Invokes search if at top, otherwise move up
        Keys.onUpPressed: {
            if (!settings["nosfx"]) sNav.play();
            if (settings["wide"]) {
                if (allView.currentIndex < settings["gamesRows"])
                    keys.invoke()
            } else {
                if (allView.currentIndex < (settings["gamesRows"] * 3))
                    keys.invoke()
            }
            if (!searching)
                moveCurrentIndexUp()
        }
        // Move down with special behavior
        Keys.onDownPressed: {
            if (!settings["nosfx"]) sNav.play();

            // Go to last element if no element below on non-final row
            if (settings["wide"]) {
                if (allView.currentIndex + (settings["gamesRows"]) >= allView.count && allView.currentIndex % (settings["gamesRows"]) > (allView.count - 1) % (settings["gamesRows"]))
                    allView.currentIndex = allView.count - 1;
                else {
                    moveCurrentIndexDown();
                }
            } else {
                if (allView.currentIndex + (settings["gamesRows"] * 3) >= allView.count && allView.currentIndex % (settings["gamesRows"] * 3) > (allView.count - 1) % (settings["gamesRows"] * 3))
                    allView.currentIndex = allView.count - 1;
                else {
                    moveCurrentIndexDown();
                }
            }
        }
        // Move left/right
        Keys.onLeftPressed: { if (!settings["nosfx"]) sNav.play(); moveCurrentIndexLeft() }
        Keys.onRightPressed: { if (!settings["nosfx"]) sNav.play(); moveCurrentIndexRight() }

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                return
            }

            // Launch Game
            if (api.keys.isAccept(event)) {
                event.accepted = true;
                if (!feed) {
                    api.memory.set("tempSavedAllGame", currentGameIndex);
                    launchGame(current);
                } else {
                    launchGame(feedCurrent);
                }
            }

            // Favorite Game / Skip Game Video
            if (api.keys.isFilters(event)) {
                event.accepted = true;
                if (!feed) {
                    if (!settings["nosfx"])
                        sFav.play();
                    current.favorite = !current.favorite;
                } else {
                    feedNext();
                }
            }

            // Quick Search with X
            if (api.keys.isDetails(event)) {
                event.accepted = true;
                if (!feed) {
                    keys.invoke()
                }
            }
        }

        Component.onCompleted: {
            positionViewAtIndex(currentIndex, GridView.Center);
        }
    }


    // Feed Stuff
    SortFilterProxyModel {
        id: gamesWithVideos;

        sourceModel: api.allGames;
        filters: [
            ExpressionFilter { expression: { assets.video !== ''; } }
        ]
    }

    Video {
        id: feedPlayer;

        width: parent.width * 0.75
        height: parent.height * 0.75
        autoPlay: true

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.1

        visible: feed

        fillMode: VideoOutput.PreserveAspectFit

        onStatusChanged: {
            if (status === MediaPlayer.InvalidMedia) {
                console.log("VIDEO INVALID");
                feedNext();
            }
            if (status === MediaPlayer.EndOfMedia) {
                console.log("VIDEO EOF");
                feedNext();
            }
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                launchGame(feedCurrent)
            }
        }
    }

    Rectangle {
        id: feedPlayerBG
        anchors.centerIn: feedPlayer;

        width: feedPlayer.width
        height: feedPlayer.height

        visible: feedPlayer.visible

        z: feedPlayer.z - 1

        color: colors["plainBG"]
    }

    Text {
        id: feedInfoLabel
        width: parent.width * .9

        y: parent.height * 0.91

        text: loc.all_feed_instructions
        color: colors["text"]

        visible: feed

        // Alignment
        horizontalAlignment: Text.AlignHCenter

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .025

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
    }

    DropShadow {
        anchors.fill: feedPlayerBG;
        source: feedPlayerBG;

        visible: feedPlayerBG.visible

        opacity: giShadowOp

        radius: giShadowRad * 2
        samples: radius * 2 + 1
        z: feedPlayerBG.z - 1
    }

    Timer {
        id: feedRepeatTimer

        interval: 500
		repeat: false
		running: false
    }

    Keys.onPressed: {
        if (event.isAutoRepeat) {
            return
        }

        // Feed Mode
        if (api.keys.isPageUp(event)) {
            event.accepted = true;

            if (feedRepeatTimer.running == false) {
                feed = !feed;
                theme.isFeed = !theme.isFeed

                if (feed) {
                    feedNext();
                } else {
                    feedPlayer.stop();
                }

                feedRepeatTimer.start()
            }

        }
    }

    function feedNext() {
        const gindex = Math.floor(Math.random() * gamesWithVideos.count);
        feedCurrent = api.allGames.get(gamesWithVideos.mapToSource(gindex));

        console.log(feedCurrent.title);
        feedPlayer.source = feedCurrent.assets.video;

        console.log(feedPlayer.source);
        feedPlayer.play();
    }

    Component.onCompleted: {
        if (api.memory.has("tempSavedAllGame")) {
            if (!settings["forceHome"]) {
                allView.currentIndex = Math.min(api.memory.get("tempSavedAllGame"), searchSort.count === 0 ? api.allGames.count : searchSort.count);
            }
            api.memory.unset("tempSavedAllGame");
        }
        feedPlayer.stop();
    }

    Connections {
        target: theme

        function onVideoControl(pause) {
            if (pause) {
                feedPlayer.pause()
            } else if (feed) {
                feedPlayer.play()
            }
        }
    }

}
