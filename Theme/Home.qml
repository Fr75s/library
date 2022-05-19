import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import SortFilterProxyModel 0.2

import "../GameItems"

FocusScope {
    id: home

    /* Focused changes the view for the home screen.
     * It scrolls the page to the favorites when they are focused.
     * 0: recent
     * 1: favorites
     */
    property int focused: 0

    // Add more recent games with moreRecents
    property int maxRecents: moreRecent ? 16 : 8

    // Sort Recents

    // Sorts by recent games, includes all games
    SortFilterProxyModel {
        id: sort_last_played_base
        sourceModel: api.allGames
        sorters: RoleSorter { roleName: "lastPlayed"; sortOrder: Qt.DescendingOrder; }
    }

    // Sorts the recent games model up to maxRecents
    SortFilterProxyModel {
        id: recent
        sourceModel: sort_last_played_base
        filters: IndexFilter { minimumIndex: 0; maximumIndex: maxRecents; }
    }

    // Sort Favorites

    // Filters by all favorite games, sorting by ascending order.
    SortFilterProxyModel {
        id: favorites
        sourceModel: api.allGames
        sorters: RoleSorter { roleName: "sortBy"; sortOrder: Qt.AscendingOrder; }
        filters: ValueFilter { roleName: "favorite"; value: true; }
    }

    // Define Current Game
    /*
    property var currentGame: {
        if (focused == 0) // If on recent, set to the current recent view game.
            api.allGames.get(sort_last_played_base.mapToSource(recentView.currentIndex))
        if (focused == 1) // If on favorites, set to the current favorited game
            api.allGames.get(favorites.mapToSource(favoriteView.currentIndex))
        else
            return null
    }
    */

    // This is the y position of the whole UI. It moves the recent view out of the way when the favorites are focused.
    property var uiY: {
        if (focused == 1)
            parent.height * -0.4
        else
            parent.height * 0.15
    }

    // Animation velocity for the vertical movement
    property int animVel: 1200

    //
    // Layouts
    //

    // Recent Games Text
    Text {
        id: recentTitle
        width: parent.width * .9

        y: uiY - parent.height * 0.075

        text: "Recent Games"
        color: light ? "black" : "white"

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        // Alignment
        horizontalAlignment: centerTitles ? Text.AlignHCenter : Text.AlignLeft

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05

        Behavior on y {
            SmoothedAnimation { velocity: animVel }
        }
    }

    // Favorite Games Text
    Text {
        id: favTitle
        width: parent.width * .9

        y: uiY + parent.height * 0.475

        text: "Favorite Games"
        color: light ? "black" : "white"

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        // Alignment
        horizontalAlignment: centerTitles ? Text.AlignHCenter : Text.AlignLeft

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05

        Behavior on y {
            SmoothedAnimation { velocity: animVel }
        }
    }

    // Clickable icon to scroll back up
    Image {
        id: homeUpArrow

        width: height
        height: parent.height * 0.1
        visible: mouseNav

        mipmap: true

        y: uiY + parent.height * 0.45

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        source: useSVG ? "../assets/theme/up.svg" : "../assets/theme/up.png"

        Behavior on y {
            SmoothedAnimation { velocity: animVel }
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (focused == 1) {
                    if (!nosfx)
                        sNav.play();
                    focused = 0;
                }
            }
        }
    }

    // Recent Games List
    // Shows all the games you've recently played.
    ListView {
        id: recentView
        width: parent.width * 0.9
        height: parent.height * 0.4

        y: uiY

        orientation: ListView.Horizontal

        model: recent

        delegate: Item {
            readonly property bool isCurrentItem: ListView.isCurrentItem
            // doubleFocus property only selects game when the view and item is this one
            readonly property bool doubleFocus: recentView.focus && isCurrentItem

            width: (index == 0 || wide) ? ListView.view.width / 2.25 : ListView.view.width / 6.75
            height: ListView.view.height

            Item {
                anchors {
                    fill: parent
                    margins: (doubleFocus) ? 0 : vpx(10)
                }

                Behavior on anchors.margins {
                    SmoothedAnimation { velocity: marginAnimVel }
                }

                GINormal { wideHead: true }

                /* No more loader, everything is already loaded on start
                Loader {
                    anchors.fill: parent
                    asynchronous: true
                    sourceComponent: GINormal { wideHead: true }
                    active: (home.focus)
                    visible: status === Loader.Ready
                }
                */

                // Click Functionality
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (doubleFocus)
                            launchGame(modelData);
                        else
                            if (focused == 1)
                                focused = 0;
                            if (!nosfx)
                                sNav.play();
                            recentView.currentIndex = index;
                    }
                }
            }
        }

        // Instant scrolling
		highlightMoveDuration: 0
		highlightResizeDuration: 0

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        clip: false
        focus: (focused == 0) && (menu == 0)

        Behavior on y {
            SmoothedAnimation { velocity: animVel }
        }

        // Scroll down when down is pressed
        Keys.onDownPressed: {
            if (!nosfx) sNav.play();
            focused = 1;
        }
        // Move left/right
        Keys.onLeftPressed: {
            if (!nosfx)
                sNav.play();
            decrementCurrentIndex();
        }
        Keys.onRightPressed: {
            if (!nosfx)
                sNav.play();
            incrementCurrentIndex();
        }

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                return
            }

            // Launch the current Game
            if (api.keys.isAccept(event)) {
                event.accepted = true;
                launchGame(api.allGames.get(sort_last_played_base.mapToSource(recentView.currentIndex)))
            }

            // Favorite/Unfavorite the current game
            if (api.keys.isFilters(event)) {
                event.accepted = true;
                if (!nosfx)
                    sFav.play();
                api.allGames.get(sort_last_played_base.mapToSource(recentView.currentIndex)).favorite = !api.allGames.get(sort_last_played_base.mapToSource(recentView.currentIndex)).favorite;
            }
        }
    }

    // Favorite Games List
    // Shows all the games you've favorited.
    GridView {
        id: favoriteView
        width: parent.width * 0.9
        height: parent.height * 0.8 //* (Math.ceil(favorites.count / 6))

        y: uiY + parent.height * 0.55

        cellWidth: wide ? (width / 2) : (width / 6)
        cellHeight: height / 2/// (Math.ceil(favorites.count / 6))

        //currentIndex: 0
        model: favorites

        delegate: Item {
            readonly property bool isCurrentItem: GridView.isCurrentItem
            // doubleFocus property only selects game when the view and item is this one
            readonly property bool doubleFocus: favoriteView.focus && isCurrentItem

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

                // Click behavior
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (doubleFocus)
                            launchGame(modelData);
                        else
                            if (focused == 0)
                                focused = 1;
                            if (!nosfx)
                                sNav.play();
                            favoriteView.currentIndex = index;
                    }
                }
            }
        }

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        clip: true
        focus: (focused == 1) && (menu == 0)

        Behavior on y {
            SmoothedAnimation { velocity: animVel }
        }

        // Scroll back up if at the top, otherwise just move up
        Keys.onUpPressed: {
            if (!nosfx)
                sNav.play();
            if (wide) {
                if (favoriteView.currentIndex < 2)
                    focused = 0
            } else {
                if (favoriteView.currentIndex < 6)
                    focused = 0
            }
            if (focused == 1)
                moveCurrentIndexUp();
        }
        // Scroll down
        Keys.onDownPressed: { if (!nosfx) sNav.play();
            // Go to last element if no element below on non-final row
            if (wide) {
                if (favoriteView.currentIndex + 2 >= favoriteView.count)
                    favoriteView.currentIndex = favoriteView.count - 1;
                else {
                    moveCurrentIndexDown();
                }
            } else {
                if (favoriteView.currentIndex + 6 >= favoriteView.count && favoriteView.currentIndex % 6 > (favoriteView.count - 1) % 6)
                    favoriteView.currentIndex = favoriteView.count - 1;
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

            // Launch selected game
            if (api.keys.isAccept(event)) {
                event.accepted = true;
                launchGame(api.allGames.get(favorites.mapToSource(favoriteView.currentIndex)))
            }
        }
    }
}
