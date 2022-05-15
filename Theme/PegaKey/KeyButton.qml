import QtQuick 2.0

Rectangle {
	/* KeyButton
	 * Defines the default style for keyboard buttons as a RoundButton
	 *
	 */

	signal clicked

	id: btn
	radius: 16

	color: light ? (clickArea.containsPress ? "#BBBBBB" : "#DDDDDD") : (clickArea.containsPress ? "#484848" : "#242424")

	property string label: ""
	property bool large: false

	Text {
		anchors.centerIn: parent

		text: label
		color: light ? "#121212" : "#EEEEEE"

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
