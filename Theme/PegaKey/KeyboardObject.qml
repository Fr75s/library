import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
	id: kRoot

	/* KeyboardObject
	 * The actual keyboard layout itself
	 *
	 */

	// Signals
	signal sendKey(string text)
	signal done()

	// Some properties that modify the characters
	property bool shift: false
	property bool alts: false

	// Quick Rowspacing and columnspacing for easy access (gutter)
	property real rowspacing: width * 0.005
	property real colspacing: rowspacing //height * 0.01

	// Highlight color
	property var keyHighlightColor: "steelblue"

	// Current Row & Column
	property int curRow: 0
	property int curCol: 0

	// Block clicking below keyboard
	MouseArea {anchors.fill: parent}

	// Background: Parent rectangle has roundness
	Rectangle {
		anchors.fill: parent
		color: light ? "#EEEEEE" : (plainBG ? "black" : "#121212")

		radius: height / 16

		Rectangle {
			anchors.fill: parent
			color: parent.color

			anchors.topMargin: height / 2
		}
	}

	// Move up/down keyboard
	Keys.onUpPressed: {
		if (curRow <= 0) {
			curRow = 3
		} else {
			curRow -= 1
		}
	}
	Keys.onDownPressed: {
		if (curRow >= 3) {
			curRow = 0
		} else {
			curRow += 1
		}
	}

	// Move left on the keyboard. Note that wider keys are hardcoded here.
	Keys.onLeftPressed: {
		if (curRow == 0) {
			if (curCol <= 0) {
				curCol = 10
			} else {
				curCol -= 1
			}
		} else if (curRow == 1) {
			if (curCol <= 0) {
				curCol = 10
			} else {
				curCol -= 1
			}
			if (curCol >= 9) {
				curCol -= 1
			}
		} else if (curRow == 2) {
			if (curCol <= 1) {
				curCol = 10
			} else {
				curCol -= 1
			}
			if (curCol >= 9) {
				curCol -= 1
			}
		} else if (curRow == 3) {
			if (curCol <= 1) {
				curCol = 10
			} else if (curCol >= 3 && curCol <= 7) {
				curCol = 2
			} else {
				curCol -= 1
			}
			if (curCol >= 9) {
				curCol -= 1
			}
		}
	}

	// Move right on the keyboard. Note that wider keys are hardcoded here as well.
	Keys.onRightPressed: {
		if (curRow == 0) {
			if (curCol >= 10) {
				curCol = 0
			} else {
				curCol += 1
			}
		} else if (curRow == 1) {
			if (curCol >= 9) {
				curCol = 0
			} else {
				curCol += 1
			}
		} else if (curRow == 2) {
			if (curCol >= 9) {
				curCol = 0
			} else {
				curCol += 1
			}
			if (curCol <= 1) {
				curCol += 1
			}
		} else if (curRow == 3) {
			if (curCol >= 3 && curCol <= 7) {
				curCol = 8
			} else if (curCol >= 9) {
				curCol = 0
			} else {
				curCol += 1
			}
			if (curCol <= 1) {
				curCol += 1
			}
		}
	}

	// Other keys
	Keys.onPressed: {
		// Space Shortcut
		if (api.keys.isFilters(event)) {
			kRoot.sendKey(" ")
		}
		// Backspace Shortcut
		if (api.keys.isDetails(event)) {
			kRoot.sendKey("\u232B")
		}
		// Exit Shortcut
		if (api.keys.isCancel(event)) {
			event.accepted = true;
			kRoot.done()
		}
	}

	Item {
		id: keymap

		// The actual keys on the keyboard

		anchors.fill: parent
		anchors.leftMargin: parent.width * 0.05
		anchors.rightMargin: parent.width * 0.05

		anchors.topMargin: parent.height * 0.025
		anchors.bottomMargin: parent.height * 0.1

		Column {
			// Keyboard Column, with rows
			spacing: colspacing

			Row { // QWERTYUIOP
				spacing: rowspacing

				Repeater {
					/* Repeaters repeat the keys
					 * Models have the following properties
					 * key: Lowercase letter (default)
					 * alt: Alternate character
					 * w: Key Width
					 * il: Lower index (used for selection)
					 * ih: Higher index (used for selection)
					 *
					 */
					model: [
						{key: "q", alt: "1", w: 1, il: 0, ih: 0},
						{key: "w", alt: "2", w: 1, il: 1, ih: 1},
						{key: "e", alt: "3", w: 1, il: 2, ih: 2},
						{key: "r", alt: "4", w: 1, il: 3, ih: 3},
						{key: "t", alt: "5", w: 1, il: 4, ih: 4},
						{key: "y", alt: "6", w: 1, il: 5, ih: 5},
						{key: "u", alt: "7", w: 1, il: 6, ih: 6},
						{key: "i", alt: "8", w: 1, il: 7, ih: 7},
						{key: "o", alt: "9", w: 1, il: 8, ih: 8},
						{key: "p", alt: "0", w: 1, il: 9, ih: 9},
						{key: "\u232B", alt: "\u232B", w: 1, il: 10, ih: 10}
					]

					delegate: KeyButton {
						label: alts ? (modelData.alt) : (shift ? modelData.key.toUpperCase() : modelData.key)

						width: modelData.w * keymap.width / 11 - rowspacing
						height: keymap.height / 4 - colspacing

						focus: curRow == 0 && (curCol >= modelData.il && curCol <= modelData.ih)

						// Key Highlight
						Rectangle {
							anchors.fill: parent
							radius: parent.radius
							border.width: 2
							border.color: "steelblue"
							color: "transparent"
							visible: curRow == 0 && (curCol >= modelData.il && curCol <= modelData.ih)
						}

						// Sending the key (click)
						onClicked: {
							kRoot.sendKey(label);
							curRow = 0;
							curCol = modelData.il;
						}

						// Sending the key (button)
						Keys.onPressed: {
							if (api.keys.isAccept(event)) {
								kRoot.sendKey(label)
							}
						}
					}

					/* The same thing with the keys here is done with the rest of the Rows.
					 *
					 */
				}
			}

			Row { // ASDFGHJKL + Enter
				spacing: rowspacing

				Repeater {
					// Key model
					model: [
						{key: "a", alt: "!", w: 1, il: 0, ih: 0},
						{key: "s", alt: "@", w: 1, il: 1, ih: 1},
						{key: "d", alt: "#", w: 1, il: 2, ih: 2},
						{key: "f", alt: "$", w: 1, il: 3, ih: 3},
						{key: "g", alt: "%", w: 1, il: 4, ih: 4},
						{key: "h", alt: "&", w: 1, il: 5, ih: 5},
						{key: "j", alt: "*", w: 1, il: 6, ih: 6},
						{key: "k", alt: "(", w: 1, il: 7, ih: 7},
						{key: "l", alt: ")", w: 1, il: 8, ih: 8},
						{key: "\u2BA8", alt: "\u2BA8", w: 2, il: 9, ih: 10}
					]

					// Button
					delegate: KeyButton {
						label: alts ? (modelData.alt) : (shift ? modelData.key.toUpperCase() : modelData.key)

						width: modelData.w * keymap.width / 11 - rowspacing
						height: keymap.height / 4 - colspacing

						focus: visible && curRow == 1 && (curCol >= modelData.il && curCol <= modelData.ih)

						// Key send (click)
						onClicked: {
							kRoot.sendKey(label);
							curRow = 1;
							curCol = modelData.il;
						}
						// Key send (button)
						Keys.onPressed: {
							if (api.keys.isAccept(event)) {
								kRoot.sendKey(label)
							}
						}

						// Key Highlight
						Rectangle {
							anchors.fill: parent
							radius: parent.radius
							border.width: 2
							border.color: keyHighlightColor
							color: "transparent"
							visible: curRow == 1 && (curCol >= modelData.il && curCol <= modelData.ih)
						}
					}
				}
			}

			Row { // sh + ZXCVBNM + sh
				spacing: rowspacing

				Repeater {
					model: [
						{key: "\u2B06", alt: "\u2B06", w: 2, il: 0, ih: 1},
						{key: "z", alt: "-", w: 1, il: 2, ih: 2},
						{key: "x", alt: "'", w: 1, il: 3, ih: 3},
						{key: "c", alt: '"', w: 1, il: 4, ih: 4},
						{key: "v", alt: "_", w: 1, il: 5, ih: 5},
						{key: "b", alt: ",", w: 1, il: 6, ih: 6},
						{key: "n", alt: "?", w: 1, il: 7, ih: 7},
						{key: "m", alt: "+", w: 1, il: 8, ih: 8},
						{key: "\u2B06", alt: "\u2B06", w: 2, il: 9, ih: 10}
					]

					delegate: KeyButton {
						label: alts ? (modelData.alt) : (shift ? modelData.key.toUpperCase() : modelData.key)

						width: modelData.w * keymap.width / 11 - rowspacing
						height: keymap.height / 4 - colspacing

						focus: visible && curRow == 2 && (curCol >= modelData.il && curCol <= modelData.ih)

						// Key send (click)
						onClicked: {
							kRoot.sendKey(label);
							curRow = 2;
							curCol = modelData.il;
						}
						// Key send (button)
						Keys.onPressed: {
							if (api.keys.isAccept(event)) {
								kRoot.sendKey(label)
							}
						}

						// Key Highlight
						Rectangle {
							anchors.fill: parent
							radius: parent.radius
							border.width: 2
							border.color: keyHighlightColor
							color: "transparent"
							visible: curRow == 2 && (curCol >= modelData.il && curCol <= modelData.ih)
						}
					}
				}
			}

			Row { // sh + ZXCVBNM + sh
				spacing: rowspacing

				Repeater {
					model: [
						{key: "&123", alt: "ABCD", w: 2, il: 0, ih: 1},
						{key: ".", alt: ".", w: 1, il: 2, ih: 2},
						{key: " ", alt: " ", w: 5, il: 3, ih: 7},
						{key: "-", alt: "-", w: 1, il: 8, ih: 8},
						{key: "CLEAR", alt: "CLEAR", w: 2, il: 9, ih: 10}
					]

					delegate: KeyButton {
						label: alts ? (modelData.alt) : (shift ? modelData.key.toUpperCase() : modelData.key)

						width: modelData.w * keymap.width / 11 - rowspacing
						height: keymap.height / 4 - colspacing

						focus: visible && curRow == 3 && (curCol >= modelData.il && curCol <= modelData.ih)

						// Key send (click)
						onClicked: {
							kRoot.sendKey(label);
							curRow = 3;
							curCol = modelData.il;
						}
						// Key send (button)
						Keys.onPressed: {
							if (api.keys.isAccept(event)) {
								kRoot.sendKey(label)
							}
						}

						// Key Highlight
						Rectangle {
							anchors.fill: parent
							radius: parent.radius
							border.width: 2
							border.color: keyHighlightColor
							color: "transparent"
							visible: curRow == 3 && (curCol >= modelData.il && curCol <= modelData.ih)
						}
					}
				}
			}

		}
	}
}
