import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import SortFilterProxyModel 0.2

import "ScrapingBackend"

FocusScope {
	id: settings

	Text {
        id: scrapeTitle
        width: parent.width * 0.9
        height: parent.height * 0.1

        text: "Scrape Games"
        color: light ? "black" : "white"

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        // Alignment
        horizontalAlignment: Text.AlignHCenter

        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05

        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.05
    }

    Text {
		id: scrapeDetails

		width: parent.width * 0.9
        height: parent.height * 0.5

		anchors.top: scrapeTitle.bottom
		anchors.topMargin: parent.height * 0.05

		anchors.horizontalCenter: parent.horizontalCenter

		text: "Welcome to the Library Scraping Tool.\nUsing some javascript magic, you are able to get game metadata from Launchbox! Simply type in the folder containing your games below, and click the button to scrape games!"
        color: light ? "black" : "white"

        font.family: gilroyLight.name
        font.pixelSize: parent.height * .05

        wrapMode: Text.WordWrap
	}
}
