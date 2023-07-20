import QtQuick 2.0
import QtMultimedia 5.9

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

	// Default Keyboard Colors
	property var kcolors: {
		"bg": "#FFFFFF", // KEYBOARD: Background
		"key": "#DDDDDD", // KEYBOARD: Key Background
		"keyPush": "#BBBBBB", // KEYBOARD: Key Background when clicked
		"keyHighlight": "#121212", // KEYBOARD: Selected Key Highlight
		"text": "#121212" // KEYBOARD: Text
	}

	// Quick Character Setting
	property string back: "\u2190"
	property string enter: "\u2192"
	property string shiftc: "\u2191"

	property url sfxSource: ""
	property bool quietSfx: false
	property bool muteSfx: false

	// Typing Sound Effect
	SoundEffect {
		id: kSfx
		source: sfxSource
		volume: quietSfx ? 0.5 : 1.0
	}

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
			if (!muteSfx) {
				kSfx.play();
			}

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
