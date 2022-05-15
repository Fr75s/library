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

	// Invokes the keyboard (shows it)
	function invoke() {
		keyboard.visible = true
		keyboard.focus = true
	}

	// The actual Keyboard Object Keyboard.qml shows
	KeyboardObject {
		id: keyboard
		visible: false

		width: theme.width
		height: theme.height * 0.6

		anchors.bottom: parent.bottom

		// Send Key is a signal of KeyboardObject.qml as well.
		onSendKey: {
			if (text == "\u232B") { // Backspace Unicode Conversion
				kcreator.sendKey("bksp")
			} else if (text == "\u2BA8") { // Enter Unicode Conversion
				keyboard.done()
			} else if (text == "\u2B06") { // Shift Unicode Conversion
				keyboard.shift = true
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
