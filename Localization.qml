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
			settings_rounded_corners: "Rounded Games",
			settings_enable_clockbar: "Enable Clock",
			settings_wide_games: "Wide Games View",
			settings_wide_games_info: "Increases the width of each game, changing to art that fits closer to the wider ratio.",
			settings_enable_touchnav: "Enable Touch Navigation Icons",
			settings_enable_touchnav_info: "Adds arrows on the top right of certain game grids to allow you to go back if you're using a touch device or mouse.",
			settings_more_recents: "More Recent Games Shown",
			settings_more_recents_info: "Increases the number of games on the Recent Games list from 8 to 16.",
			settings_limit_search: "Limit Search to Starting Characters",
			settings_limit_search_info: "Makes it so that searches search for games that start with the text searched, not games that contain the text searched (both in their titles)",
			settings_enlarge_bar: "Enlarge Bottom Bar",
			settings_enlarge_bar_info: "Doubles the size of the bottom bar for easier mouse/touch navigation.",
			settings_use_svg: "Use SVG Icons",
			settings_use_svg_info: "Allows you to use higher quality SVG icons rather than PNG icons. Higher quality on very large screens, but may break images on some devices.",
			settings_classic_colors: "Use Classic Colorscheme",
			settings_classic_colors_info: "Reverts the colors of the UI back to the colors used in Library prior to version 1.2.0.",
			settings_quiet_sounds: "Quiet Sound Effects",
			settings_mute_sounds: "Mute Sound Effects",
			settings_video_playback: "Video playback",
			settings_blur_collects: "Blur Collection Images",
			settings_change_localization: "Change Language",
			bottomBar_changePage: "Change Page",
			bottomBar_aSelect: "Select",
			bottomBar_aPlay: "Play",
			bottomBar_aSetting: "Change Setting",
			bottomBar_bKeyboard: "Hide Keyboard",
			bottomBar_bExit: "Exit Collection",
			bottomBar_xKeyboard: "Keyboard / Backspace",
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
            settings_rounded_corners: "Abgerundete Spiele",
            settings_enable_clockbar: "Uhr anzeigen",
            settings_wide_games: "Breite Spiele-Ansicht",
            settings_wide_games_info: "Erhöht die Breite jedes Spiels und wechselt zu Grafiken, die besser in das breitere Verhältnis passen.",
            settings_enable_touchnav: "Touch-Navigationssymbole aktivieren",
            settings_enable_touchnav_info: "Fügt Pfeile oben rechts in bestimmten Spielrastern hinzu, damit man zurückgehen kann, wenn man ein Touch-Gerät oder eine Maus benutzt.",
            settings_more_recents: "Zeige mehr zuletzt gespielte Spiele",
            settings_more_recents_info: "Erhöht die Anzahl der Spiele in der Liste der zuletzt gespielten Spiele von 8 auf 16.",
            settings_limit_search: "Suche auf Textanfang beschränken",
            settings_limit_search_info: "Sorgt dafür, dass nach Spielen gesucht wird, die mit dem gesuchten Text beginnen, und nicht nach Spielen, die den gesuchten Text enthalten (beide in ihren Titeln)",
			settings_enlarge_bar: "Vergrößere untere Leiste",
			settings_enlarge_bar_info: "Verdopple die Größe der unteren Leise für leichtere Maus / Touch navigation.",
			settings_use_svg: "Verwende SVG Icons",
			settings_use_svg_info: "Ermöglicht die Verwendung von SVG-Symbolen in höherer Qualität anstelle von PNG-Symbolen. Bessere Qualität auf sehr großen Bildschirmen, aber die Bilder können auf manchen Geräten fehlerhaft dargestellt werden.",
			settings_classic_colors: "Verwende klassisches Farbschema",
			settings_classic_colors_info: "Benutzeroberfläche verwendet Farbschemas, die in Library vor Version 1.2.0 verwendet wurden",
			settings_quiet_sounds: "Leisere Soundeffekte",
			settings_mute_sounds: "Soundeffekte stummschalten",
			settings_video_playback: "Videowiedergabe",
			settings_blur_collects: "Unscharfe Sammlungsbilder",
			settings_change_localization: "Anzeigesprache",
			bottomBar_changePage: "Seite wechseln",
			bottomBar_aSelect: "Auswählen",
			bottomBar_aPlay: "Spielen",
			bottomBar_aSetting: "Einstellung ändern",
			bottomBar_bKeyboard: "verstecke Tastatur",
			bottomBar_bExit: "Sammlung verlassen",
			bottomBar_xKeyboard: "Tastatur / Rücktaste",
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
