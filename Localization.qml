import QtQuick 2.8

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

	/* Currently, only English is available.
	 * Translations are welcome: Simply create a pull request on github or message me on discord (Francisco75s#0331) to let me know if you have a good translation, and I will add it to the theme.
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
			settings_change_localization: "Change Language"
		}
	}

	function getLocalization(lang) {
		return localization[lang]
	}

	function getLangs() {
		return Object.keys(localization)
	}
}
