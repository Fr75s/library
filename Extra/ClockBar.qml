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

		opacity: 0.5
		color: colors["clockBarBG"]
	}

	Text {
		/* I have known of this method of a time text since first dabbling with Pegasus
		 * It's from somewhere, but I have no idea where.
		 */
		id: currentTime

		// Set Time
		function set() {
			currentTime.text = settings["24hClock"] ? Qt.formatTime(new Date(), "hh:mm") : Qt.formatTime(new Date(), "hh:mm AP");
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

		color: colors["text"]
		font.family: gilroyExtraBold.name
		font.pixelSize: height / 2
		font.bold: true
	}

	Text {
		id: batteryIcon

		width: parent.width * 0.002
		height: parent.height

		anchors.left: currentTime.left
		anchors.leftMargin: currentTime.contentWidth + parent.width * 0.018

		text: isNaN(api.device.batteryPercent) ? "" : getBatteryIcon(api.device.batteryPercent)

		font {
			family: icons.name;
			pixelSize: height / 2
		}

		color: colors["text"]
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

		text: isNaN(api.device.batteryPercent) ? "" : formPercent(api.device.batteryPercent) + "%"
		color: colors["text"]
		font.family: gilroyExtraBold.name
		font.pixelSize: height / 2
	}


	// Makes battery percentage readable (rather than a random decimal number)
	function getBatteryIcon(percent) {

		// Battery Percent must be less than or equal to KEY to be VALUE
		if (api.device.batteryCharging && api.device.batteryPercent <= 1) {
			return "\ue837";
		} else {
			var batteryConvert = {
				5: "\ue82c",
				10: "\ue82d",
				20: "\ue82e",
				30: "\ue82f",
				40: "\ue830",
				50: "\ue831",
				60: "\ue832",
				70: "\ue833",
				80: "\ue834",
				90: "\ue835",
				100: "\ue836",
			}

			var clean_percent = Math.round(percent * 100);

			var index = 0;
			var range_r = Object.keys(batteryConvert)[index];
			while (clean_percent > range_r && clean_percent <= 100) {
				index += 1;
				range_r = Object.keys(batteryConvert)[index];
			}

			return batteryConvert[range_r];
		}
	}

	function formPercent(percent) {
		return Math.round(percent * 100);
	}

}
