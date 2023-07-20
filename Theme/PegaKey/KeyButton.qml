import QtQuick 2.0
import QtMultimedia 5.9

Rectangle {
	/* KeyButton
	 * Defines the default style for keyboard buttons as a RoundButton
	 *
	 */

	signal clicked

	id: btn
	radius: 16

	property var clickedColor: "#000000"
	property var regColor: "#FFFFFF"
	property var textColor: "#888888"

	color: clickArea.containsPress ? clickedColor : regColor

	property string label: ""
	property bool large: false

	Text {
		anchors.centerIn: parent

		text: label
		color: textColor

		font.family: gilroyLight.name
		font.pixelSize: large ? btn.height / 2 : btn.height / 5
	}

	MouseArea {
		id: clickArea
		anchors.fill: parent

		onPressed: {
			btn.clicked()
		}
	}
}
