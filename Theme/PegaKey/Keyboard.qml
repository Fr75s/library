import QtQuick 2.0

Item {

	/* Keyboard
	 * Keyboard.qml instantiates a KeyboardObject. It is not the keyboard itself.
	 * It obviously shows and hides the keyboard, but it also converts several keys.
	 *
	 */

	id: kcreator

	focus: false

	// Signals
	signal invoked()
	signal sendKey(string text)
	signal done()

	property var kcolors: {
		"bg": "#FFFFFF", // KEYBOARD: Background
		"key": "#DDDDDD", // KEYBOARD: Key Background
		"keyPush": "#BBBBBB", // KEYBOARD: Key Background when clicked
		"keyHighlight": "#121212", // KEYBOARD: Selected Key Highlight
		"text": "#121212" // KEYBOARD: Text
	}

	// Quick Character Setting
	property string back: "\u2190"
	property string enter: "\u2193"
	property string shiftc: "\u2191"

	// Invokes the keyboard (shows it)
	function invoke() {
		keyboard.visible = true
		keyboard.focus = true
		// This allows the keyboard to immediately accept presses vs waiting to move the cursor
		keyboard.focusEnableKB()
	}

	// The actual Keyboard Object Keyboard.qml shows
	KeyboardObject {
		id: keyboard
		visible: false
		colors: kcolors

		backChar: back
		enterChar: enter
		shiftChar: shiftc

		width: theme.width
		height: theme.height * 0.6

		anchors.bottom: parent.bottom

		// Send Key is a signal of KeyboardObject.qml as well.
		onSendKey: {
			if (text == back) { // Backspace Unicode Conversion
				kcreator.sendKey("bksp")
			} else if (text == enter) { // Enter Unicode Conversion
				keyboard.done()
			} else if (text == shiftc) { // Shift Unicode Conversion
				keyboard.shift = !keyboard.shift
			} else if (text == "&123" || text == "ABCD") { // Alt Conversion
				keyboard.alts = !keyboard.alts
			} else {
				kcreator.sendKey(text)
				if (keyboard.shift) {
					keyboard.shift = false
				}
			}
		}

		// Hides keyboard once done
		onDone: {
			kcreator.done()
			focus = false
			visible = false
		}
	}

}
