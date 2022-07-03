import QtQuick 2.8
import QtMultimedia 5.9
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

    // Define Current Game
    SortFilterProxyModel {
        id: searchSort
        sourceModel: api.allGames

        // The searching functionality for the model
        filters: RegExpFilter {
            roleName: "title";
            // Limited search matches ^[term] rather than [term]
            pattern: limSearch ? "^" + searchInput.text : searchInput.text;
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
    property var current: {
        if (searchSort.count == 0 || searchSort.count == api.allGames.count)
            return api.allGames.get(allView.currentIndex)
        else
            return api.allGames.get(searchSort.mapToSource(allView.currentIndex))
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

        text: feed ? "Feed" : "Search"
        color: light ? "black" : "white"

        // Alignment
        horizontalAlignment: Text.AlignLeft

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
    }

    // Search text input, used for searching
    // Its text property is what is used for searching
    Text {
        id: searchInput
        width: parent.width * .6

        visible: !feed

        y: parent.height * 0.075

        color: light ? "black" : "white"

        // Alignment
        horizontalAlignment: Text.AlignLeft

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        // Background, to indicate it is a search field
        Rectangle {
            id: searchInputBG
            z: parent.z - 1

            width: parent.width + (parent.height * .5)
            height: parent.height * 1.2

            anchors.centerIn: parent

            radius: height * .25
            opacity: plainBG ? 1 : 0.6
            color: light ? "#EEEEEE" : "#242424"

            // Highlight when searching
            Rectangle {
                anchors.fill: parent
                radius: parent.radius

                visible: (menu == 1) && !(allView.focus)

                border.color: "steelblue"
                border.width: 2
                color: "transparent"
            }
        }

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

            onClicked: keys.invoke()
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
        width: parent.width * 0.9
        height: parent.height * 0.8 //* (Math.ceil(api.allGames.count / 6))

        anchors.top: parent.top
        anchors.topMargin: parent.height * .15

        visible: !feed

        // Grid
        cellWidth: wide ? (width / 2) : (width / 6)
        cellHeight: height / 2

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
                            if (!nosfx)
                                sNav.play();
                            if (searching)
                                searching = false
                        }
                    }
                }
            }


        }

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        clip: true
        focus: (menu == 1) && !searching

        // Invokes search if at top, otherwise move up
        Keys.onUpPressed: {
            if (!nosfx) sNav.play();
            if (wide) {
                if (allView.currentIndex < 2)
                    keys.invoke()
            } else {
                if (allView.currentIndex < 6)
                    keys.invoke()
            }
            if (!searching)
                moveCurrentIndexUp()
        }
        // Move down with special behavior
        Keys.onDownPressed: { if (!nosfx) sNav.play();
            // Go to last element if no element below on non-final row
            if (wide) {
                if (allView.currentIndex + 2 >= allView.count)
                    allView.currentIndex = allView.count - 1;
                else {
                    moveCurrentIndexDown();
                }
            } else {
                if (allView.currentIndex + 6 >= allView.count && allView.currentIndex % 6 > (allView.count - 1) % 6)
                    allView.currentIndex = allView.count - 1;
                else {
                    moveCurrentIndexDown();
                }
            }
        }
        // Move left/right
        Keys.onLeftPressed: { if (!nosfx) sNav.play(); moveCurrentIndexLeft() }
        Keys.onRightPressed: { if (!nosfx) sNav.play(); moveCurrentIndexRight() }

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                return
            }

            // Launch Game
            if (api.keys.isAccept(event)) {
                event.accepted = true;
                if (!feed) {
                    launchGame(current);
                } else {
                    launchGame(feedCurrent);
                }
            }

            // Favorite Game
            if (api.keys.isFilters(event)) {
                event.accepted = true;
                if (!feed) {
                    if (!nosfx)
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

        color: "#000000"
    }

    Text {
        id: feedInfoLabel
        width: parent.width * .9

        y: parent.height * 0.91

        text: "Press L2 at any time to stop."
        color: light ? "black" : "white"

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

    Keys.onPressed: {
        if (event.isAutoRepeat) {
            return
        }

        // Feed Mode
        if (api.keys.isPageUp(event)) {
            event.accepted = true;
            feed = !feed;

            if (feed) {
                feedNext();
            } else {
                feedPlayer.stop();
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
