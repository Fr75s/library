import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Row {
	/* IconPair
	 * Defines an icon and text for button icons
	 *
	 */

	// Image Source
	property url src: ""

	// Labels for each page, with each element corresponding to each page
	property var label: ["0", "1", "2", "3"]

	spacing: (textContent.width + height) * 0.05

	width: textContent.width + height + spacing

	visible: (label[menu] != "")

	Item { // Home
		width: height
		height: parent.height * .8
		anchors.verticalCenter: parent.verticalCenter
		// Icon
		Image {
			id: iconpicon
			anchors.fill: parent
			mipmap: true
			source: src
			visible: false
		}
		// Used to color the icon
		ColorOverlay {
            anchors.fill: iconpicon
            source: iconpicon
			color: colors["bottomIcons"]
		}
	}

	// Text
	Text {
		id: textContent
		height: parent.height
		width: contentWidth

		text: label[menu]
		color: colors["bottomIcons"]

		font.pixelSize: parent.height * .6
		font.family: gilroyLight.name
		verticalAlignment: Text.AlignVCenter

	}
}
