import QtQuick 2.8

/*

TRANSLATION CREDITS:

Fr75s: English (EN)

TigraTT-Driver: German (DE)

*/

Item {
	visible: false

	// Localization Chart

	/* Simply insert another language (e.g. "es") as a code and copy all the keys from the "en" object into your object like so:
	 * "es": {
	 *   home_recent: "...",
	 *   home_favorite: "...",
	 *   ...
	 * }
	 */

	/* Translations are welcome: Simply create a pull request on github or message me on discord (Francisco75s#0331) or matrix (@fr75s:matrix.org) to let me know if you have a good translation, and I will add it to the theme.
	 *
	 * TRANSLATION NOTE: If you've previously contributed, please add any translations to any fields labeled [], as these indicate new text that need to be translated.
	 *
	 * See more in the Translation section of MODIFICATIONS.md
	 */

	property var localization: {
		"en": {
			home_recent: "Recent Games",
			home_favorite: "Favorite Games",
			all_search: "Search",
			all_feed: "Feed",
			all_feed_instructions: "Press L2 at any time to stop.",
			collections_title: "Collections",
			settings_title: "Settings",
			settings_light_mode: "Light Mode",
			settings_plain_bg: "Plain Background",
			settings_disable_buttons: "Disable Button Prompts",
			settings_button_scheme: "Button Prompt Style",
			settings_rounded_corners: "Rounded Games",
			settings_center_titles: "Center Titles",
			settings_enable_clockbar: "Enable Clock",
			settings_wide_games: "Wide Games View",
			settings_wide_games_info: "Increases the width of each game, changing to art that fits closer to the wider ratio.",
			settings_games_grid_rows: "Number of Rows per Screen for Games",
			settings_collection_grid_rows: "Number of Rows per Screen for Collections",
			settings_enable_touchnav: "Enable Touch Navigation Icons",
			settings_enable_touchnav_info: "Adds arrows on the top right of certain game grids to allow you to go back if you're using a touch device or mouse.",
			settings_more_recents: "More Recent Games Shown",
			settings_more_recents_info: "Increases the number of games on the Recent Games list from 8 to 16.",
			settings_limit_search: "Limit Search to Starting Characters",
			settings_limit_search_info: "Makes it so that searches search for games that start with the text searched, not games that contain the text searched (both in their titles)",
			settings_enlarge_bar: "Change Bar Size",
			settings_bar_size_tiny: "tiny",
			settings_bar_size_small: "small",
			settings_bar_size_medium: "medium",
			settings_bar_size_large: "large",
			settings_classic_colors: "Use Classic Colorscheme",
			settings_classic_colors_info: "Reverts the colors of the UI back to the colors used in Library prior to version 1.2.0.",
			settings_disable_wide_header: "Disable Wide Game Titles",
			settings_quiet_sounds: "Quiet Sound Effects",
			settings_mute_sounds: "Mute Audio",
			settings_video_playback: "Video Playback",
			settings_blur_collects: "Blur Collection Images",
			settings_change_localization: "Change Language",
			settings_change_bg: "Change Background",
			settings_24h_clock: "24-hour clock",

			settings_header_appearance: "Appearance",
			settings_header_behavior: "Behavior",
			settings_header_av: "Audio & Video",
			settings_header_interface: "Interface",
			settings_header_localization: "Localization",

			bottomBar_changePage: "Change Page",
			bottomBar_aSelect: "Select",
			bottomBar_aPlay: "Play",
			bottomBar_aSetting: "Change Setting",
			bottomBar_bKeyboard: "Hide Keyboard",
			bottomBar_bExit: "Exit Collection",
			bottomBar_xKeyboard: "Keyboard / Backspace",
			bottomBar_xNext: "Next Section",
			bottomBar_yFavorite: "Favorite",
			bottomBar_yNext: "Next",
			bottomBar_yKeyboard: "Favorite / Space",
			bottomBar_yInfo: "Show Extra Info"

		},
		"de": {
            home_recent: "Zuletzt gespielt",
			home_favorite: "Lieblings Spiele",
            all_search: "Suche",
            all_feed: "Feed",
            all_feed_instructions: "Drücke L2 um Spiele-Feed-Modus zu verlassen.",
            collections_title: "Sammlungen",
            settings_title: "Einstellungen",
            settings_light_mode: "Heller-Modus",
            settings_plain_bg: "Einfarbiger Hintergrund",
            settings_disable_buttons: "Eingabehilfen deaktivieren",
			settings_button_scheme: "Design der Eingabehilfe",
            settings_rounded_corners: "Abgerundete Spiele",
			settings_center_titles: "Überschriften zentrieren",
            settings_enable_clockbar: "Uhr anzeigen",
            settings_wide_games: "Breite Spiele-Ansicht",
            settings_wide_games_info: "Erhöht die Breite jedes Spiels und wechselt zu Grafiken, die besser in das breitere Verhältnis passen.",
			settings_games_grid_rows: "Anzahl der Reihen für Spielelisten",
			settings_collection_grid_rows: "Anzahl der Reihen für die Sammlungen-Übersicht",
            settings_enable_touchnav: "Touch-Navigationssymbole aktivieren",
            settings_enable_touchnav_info: "Fügt Pfeile oben rechts in bestimmten Spielrastern hinzu, damit man zurückgehen kann, wenn man ein Touch-Gerät oder eine Maus benutzt.",
            settings_more_recents: "Zeige mehr zuletzt gespielte Spiele",
            settings_more_recents_info: "Erhöht die Anzahl der Spiele in der Liste der zuletzt gespielten Spiele von 8 auf 16.",
            settings_limit_search: "Suche auf Textanfang beschränken",
            settings_limit_search_info: "Sorgt dafür, dass nach Spielen gesucht wird, die mit dem gesuchten Text beginnen, und nicht nach Spielen, die den gesuchten Text enthalten (beide in ihren Titeln)",
			settings_enlarge_bar: "Leistengröße",
			settings_bar_size_tiny: "winzig",
			settings_bar_size_small: "klein",
			settings_bar_size_medium: "mittel",
			settings_bar_size_large: "groß",
			settings_classic_colors: "Verwende klassisches Farbschema",
			settings_classic_colors_info: "Benutzeroberfläche verwendet Farbschemas, die in Library vor Version 1.2.0 verwendet wurden",
			settings_disable_wide_header: "Deaktiviere Spieletitel-Banner bei der breiten Spiele-Ansicht",
			settings_quiet_sounds: "Leisere Soundeffekte",
			settings_mute_sounds: "Soundeffekte stummschalten",
			settings_video_playback: "Videowiedergabe",
			settings_blur_collects: "Unscharfe Sammlungsbilder",
			settings_change_localization: "Anzeigesprache",
			settings_change_bg: "Hintergrund ändern",
			settings_24h_clock: "24-Stunden Uhr",

			settings_header_appearance: "Erscheinungsbild",
			settings_header_behavior: "Verhalten",
			settings_header_av: "Audio & Video",
			settings_header_interface: "Oberfläche",
			settings_header_localization: "Lokalisierung",

			bottomBar_changePage: "Seite wechseln",
			bottomBar_aSelect: "Auswählen",
			bottomBar_aPlay: "Spielen",
			bottomBar_aSetting: "Einstellung ändern",
			bottomBar_bKeyboard: "verstecke Tastatur",
			bottomBar_bExit: "Sammlung verlassen",
			bottomBar_xKeyboard: "Tastatur / Rücktaste",
			bottomBar_xNext: "Nächster Abschnitt",
			bottomBar_yFavorite: "Favorit",
			bottomBar_yNext: "Nächstes",
			bottomBar_yKeyboard: "Favorit / Leertaste",
			bottomBar_yInfo: "Mehr Infos"
		}
	}

	function getLocalization(lang) {
		return localization[lang]
	}

	function getLangs() {
		return Object.keys(localization)
	}
}
