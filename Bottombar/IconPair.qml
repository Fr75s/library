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
	property url srcp: ""

	// Labels for each page, with each element corresponding to each page
	property var label: ["0", "1", "2", "3"]

	spacing: (textContent.width + height) * 0.05

	width: textContent.width + height + spacing

	visible: (label[menu] != "")

	// Icon
	Image {
		id: iconpicon
		width: height
		height: parent.height * .8

		anchors.verticalCenter: parent.verticalCenter

		source: useSVG ? src : srcp
		visible: false
	}

	// Used to color the icon
	ColorOverlay {
		width: iconpicon.width
		height: iconpicon.height
		source: iconpicon
		color: colors["bottomIcons"]
		anchors.verticalCenter: parent.verticalCenter
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
