import QtQuick 2.0
import QtQuick.Controls 2.15

RoundButton {
	/* KeyButton
	 * Defines the default style for keyboard buttons as a RoundButton
	 *
	 */

	id: btn
	radius: 16

	property string label: ""
	property bool large: false

	background: Rectangle {
		radius: btn.radius

		color: light ? (btn.pressed ? "#BBBBBB" : "#DDDDDD") : (btn.pressed ? "#484848" : "#242424")
	}

	Text {
		anchors.centerIn: parent

		text: label
		color: light ? "#121212" : "#EEEEEE"

		font.family: gilroyLight.name
		font.pixelSize: large ? btn.height / 2 : btn.height / 5
	}
}
