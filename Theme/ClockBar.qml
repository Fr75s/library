import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

Item {
	// A simple clock bar at the top of the screen

	width: parent.width
	height: parent.height * 0.035

	Rectangle {

		width: parent.width
		height: parent.height

		color: light ? "#88FFFFFF" : "#88000000"
	}

	Text {
		/* I have known of this method of a time text since first dabbling with Pegasus
		 * It's from somewhere, but I have no idea where.
		 */
		id: currentTime

		// Set Time
		function set() {
			currentTime.text = Qt.formatTime(new Date(), "hh:mm AP");
		}

		// Runs the timer to update the time every second
		Timer {
			id: currentTimeTextTimer
			interval: 1000 // Run the timer every second
			repeat: true
			running: true
			triggeredOnStart: true // Start immediately
			onTriggered: currentTime.set()
		}

		width: parent.width * 0.95
		anchors.horizontalCenter: parent.horizontalCenter
		height: parent.height

		horizontalAlignment: Text.AlignLeft
		verticalAlignment: Text.AlignVCenter

		color: light ? "black" : "white"
		font.family: gilroyExtraBold.name
		font.pixelSize: height / 2
		font.bold: true
	}

	Text {
		/* Lists the battery, not much more.
		 */
		id: battery

		width: contentWidth
		height: parent.height

		anchors.left: currentTime.left
		anchors.leftMargin: currentTime.contentWidth + parent.width * 0.02

		horizontalAlignment: Text.AlignLeft
		verticalAlignment: Text.AlignVCenter

		text: isNaN(api.device.batteryPercent) ? "" : api.device.batteryPercent + "%"
		color: light ? "black" : "white"
		font.family: gilroyExtraBold.name
		font.pixelSize: height / 2
	}

}
