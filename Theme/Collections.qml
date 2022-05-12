import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import SortFilterProxyModel 0.2

import "../GameItems"

FocusScope {
    id: collects

    /* gameView shows the games in a collection once clicked.
     * It sets the visible property of each GridView here.
     * false: Collections View
     * true: Game View
     */
    property bool gameView: false

    /* Sets whether or not you're in a collection
     * 0: Collections
     * 1: Games
     */
    property var collection: 0
    // Adds a delay to mouse clicks on the collection screen so that they don't immediately click a game
    property bool interact: true

    // Collections Title
    Text {
        id: tlText
        width: parent.width * .9

        y: parent.height * 0.075

        text: "Collections"
        color: light ? "black" : "white"

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        // Alignment
        horizontalAlignment: centerTitles ? Text.AlignHCenter : Text.AlignLeft

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05

        opacity: gameView ? 0 : 1
    }

    // Games Title
    Text {
        id: llText
        width: parent.width * .9

        y: parent.height * 0.075

        text: collection.name
        color: light ? "black" : "white"

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        // Alignment
        horizontalAlignment: centerTitles ? Text.AlignHCenter : Text.AlignLeft

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05

        opacity: gameView ? 1 : 0
    }

    // Clickable Mouse Navigation
    Image {
        id: collectionBackArrow

        height: parent.height * 0.075
        width: height

        mipmap: true

        y: parent.height * 0.075

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        visible: gameView && mouseNav

        source: "../assets/theme/up.svg"

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (!nosfx)
                    sBack.play();
                gameView = false;
            }
        }
    }

    /* collectionsView: Shows collections
     * Works just like a gameView, but has some key differences
     *
     */
    GridView {
        id: collectionsView
        width: parent.width * 0.9
        height: parent.height * 0.8 //* (Math.ceil(api.allGames.count / 6))

        anchors.top: parent.top
        anchors.topMargin: parent.height * .15

        cellWidth: width / 6
        cellHeight: height / 2 /// (Math.ceil(api.allGames.count / 6))

        // Collections model from Pegasus
        model: api.collections

        delegate: Item {
            readonly property bool isCurrentItem: GridView.isCurrentItem
            // doubleFocus again focuses the highlighted item
            readonly property bool doubleFocus: collectionsView.focus && isCurrentItem

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

                /* Instead of GINormal, this view uses GICusart
                 * This is to permit collection art to show rather than game art.
                 *
                 */
                GICusart{}

                /*
                Loader {
                    anchors.fill: parent
                    asynchronous: true
                    sourceComponent: GICusart{}
                    active: collects.focus
                    visible: status === Loader.Ready
                }
                */

                // Click functionality
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (isCurrentItem) {
                            if (!nosfx)
                                sAccept.play();
                            collection = api.collections.get(collectionsView.currentIndex);
                            // We set interact to false so that the click doesn't interact
                            interact = false;
                            gameView = true;
                            // Timeout is .5s, enough to let go of the previous click
                            setTimeout({interact = true}, 500)
                        } else {
                            if (!nosfx)
                                sNav.play();
                            collectionsView.currentIndex = index;
                        }
                    }
                }
            }
        }

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        clip: true
        focus: (menu == 2) && !(gameView)
        visible: !gameView

        // Go up
        Keys.onUpPressed: { if (!nosfx) sNav.play(); moveCurrentIndexUp() }
        // Go down with special property
        Keys.onDownPressed: { if (!nosfx) sNav.play();
            // Go to last element if no element below on non-final row
            if (collectionsView.currentIndex + 6>= collectionsView.count && collectionsView.currentIndex % 6 > (collectionsView.count - 1) % 6)
                collectionsView.currentIndex = collectionsView.count - 1;
            else {
                moveCurrentIndexDown();
            }
        }
        // Go left/right
        Keys.onLeftPressed: { if (!nosfx) sNav.play(); moveCurrentIndexLeft() }
        Keys.onRightPressed: { if (!nosfx) sNav.play(); moveCurrentIndexRight() }

        Keys.onPressed: {
            // Stop auto repeat: Don't open a game if A is held down.
            if (event.isAutoRepeat) {
                return
            }

            // Open the current collection
            if (api.keys.isAccept(event)) {
                if (!nosfx)
                    sAccept.play();
                // Set the current Collection
                collection = api.collections.get(collectionsView.currentIndex)
                gameView = true
            }
        }
    }

    // Actual Games in a collection
    GridView {
        id: collectionGamesView
        width: parent.width * 0.9
        height: parent.height * 0.8 //* (Math.ceil(api.allGames.count / 6))

        anchors.top: parent.top
        anchors.topMargin: parent.height * .15

        cellWidth: wide ? (width / 2) : (width / 6)
        cellHeight: height / 2 /// (Math.ceil(api.allGames.count / 6))

        // Games in the current collection is the model
        model: collection.games

        delegate: Item {
            readonly property bool isCurrentItem: GridView.isCurrentItem
            // Again, doubleFocus, doing the same thing
            readonly property bool doubleFocus: collectionGamesView.focus && isCurrentItem

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
                    sourceComponent: GINormal{}
                    active: collects.focus
                    visible: status === Loader.Ready
                }
                */

                // Click functionality
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (isCurrentItem) {
                            launchGame(modelData);
                        }
                        else {
                            collectionGamesView.currentIndex = index;
                            if (!nosfx)
                                sNav.play();
                        }
                    }
                }
            }
        }

        anchors.right: parent.right
        anchors.rightMargin: parent.width * 0.05

        clip: true
        focus: (menu == 2) && (gameView)
        visible: gameView

        // Move up, down, left & right like collectionsView
        Keys.onUpPressed: { if (!nosfx) sNav.play(); moveCurrentIndexUp() }
        Keys.onDownPressed: { if (!nosfx) sNav.play();
            // Go to last element if no element below on non-final row
            if (wide) {
                if (collectionGamesView.currentIndex + 2 >= collectionGamesView.count)
                    collectionGamesView.currentIndex = collectionGamesView.count - 1;
                else {
                    moveCurrentIndexDown();
                }
            } else {
                if (collectionGamesView.currentIndex + 6>= collectionGamesView.count && collectionGamesView.currentIndex % 6 > (collectionGamesView.count - 1) % 6)
                    collectionGamesView.currentIndex = collectionGamesView.count - 1;
                else {
                    moveCurrentIndexDown();
                }
            }
        }
        Keys.onLeftPressed: { if (!nosfx) sNav.play(); moveCurrentIndexLeft() }
        Keys.onRightPressed: { if (!nosfx) sNav.play(); moveCurrentIndexRight() }

        Keys.onPressed: {
            if (event.isAutoRepeat) {
                return
            }

            // Launch game, only on interact
            if (api.keys.isAccept(event)) {
                if (interact) {
                    event.accepted = true;
                    launchGame(collection.games.get(collectionGamesView.currentIndex))
                }
            }

            // Go back to the collections
            if (api.keys.isCancel(event)) {
                if (!nosfx)
                    sBack.play();
                event.accepted = true;
                gameView = false
            }

            // Favorite a game
            if (api.keys.isFilters(event)) {
                if (!nosfx)
                    sFav.play();
                event.accepted = true;
                collection.games.get(collectionGamesView.currentIndex).favorite = !collection.games.get(collectionGamesView.currentIndex).favorite;
            }
        }
    }

}
