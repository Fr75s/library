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
			settings_diff_aspect: "Change Aspect Ratios",
			settings_diff_aspect_info: "Changes each game's aspect ratios from 2:3 and 92:43 to 3:4 and 16:9",
			settings_show_wide_times: "Show Playtime (Wide View)",
			settings_force_recent_narrow: "Override Wide 1st Recent Game",
			settings_force_recent_narrow_info: "Makes the first game in the \"Recent Games\" section portrait, similar to other games when Wide Games View is disabled.",
			settings_games_grid_rows: "Number of Rows per Screen for Games",
			settings_collection_grid_rows: "Number of Rows per Screen for Collections",
			settings_enable_touchnav: "Enable Touch Navigation Icons",
			settings_enable_touchnav_info: "Adds arrows on the top right of certain game grids to allow you to go back if you're using a touch device or mouse.",
			settings_more_recents: "More Recent Games Shown",
			settings_more_recents_info: "Increases the number of games on the Recent Games list from 8 to 16.",
			settings_limit_search: "Limit Search to Starting Characters",
			settings_limit_search_info: "Makes it so that searches search for games that start with the text searched, not games that contain the text searched (both in their titles)",
			settings_search_mode: "Search Mode",
			settings_search_mode_info: "Changes how games are found using the given search prompt in the search tab. Refer to EXTRAINFO.md in the theme folder for more info.",
			settings_search_mode_regular: "regular",
			settings_search_mode_limited: "limited",
			settings_search_mode_fuzzy: "fuzzy",
			settings_search_mode_raw: "raw",
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

			playtime_never: "Never",
			playtime_seconds: "s",
			playtime_minutes: "m",
			playtime_hours: "h",

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
			settings_diff_aspect: "[]",
			settings_diff_aspect_info: "[]",
			settings_show_wide_times: "[]",
			settings_force_recent_narrow: "[]",
			settings_force_recent_narrow_info: "[]",
			settings_games_grid_rows: "Anzahl der Reihen für Spielelisten",
			settings_collection_grid_rows: "Anzahl der Reihen für die Sammlungen-Übersicht",
            settings_enable_touchnav: "Touch-Navigationssymbole aktivieren",
            settings_enable_touchnav_info: "Fügt Pfeile oben rechts in bestimmten Spielrastern hinzu, damit man zurückgehen kann, wenn man ein Touch-Gerät oder eine Maus benutzt.",
            settings_more_recents: "Zeige mehr zuletzt gespielte Spiele",
            settings_more_recents_info: "Erhöht die Anzahl der Spiele in der Liste der zuletzt gespielten Spiele von 8 auf 16.",
            settings_limit_search: "Suche auf Textanfang beschränken",
            settings_limit_search_info: "Sorgt dafür, dass nach Spielen gesucht wird, die mit dem gesuchten Text beginnen, und nicht nach Spielen, die den gesuchten Text enthalten (beide in ihren Titeln)",
            settings_search_mode: "[]",
			settings_search_mode_info: "[]",
			settings_search_mode_regular: "[]",
			settings_search_mode_limited: "[]",
			settings_search_mode_fuzzy: "[]",
			settings_search_mode_raw: "[]",
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

			playtime_never: "[]",
			playtime_seconds: "s",
			playtime_minutes: "m",
			playtime_hours: "h",

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
		},
		"ja": {
			home_recent: "最近プレイしたゲーム",
			home_favorite: "お気に入りのゲーム",
			all_search: "検索",
			all_feed: "フィード",
			all_feed_instructions: "停止するには L2 を押してください。",
			collections_title: "コレクション",
			settings_title: "設定",
			settings_light_mode: "ライトモード",
			settings_plain_bg: "シンプル背景",
			settings_disable_buttons: "ボタンガイドを無効にする",
			settings_button_scheme: "ボタンガイドのスタイル",
			settings_rounded_corners: "サムネイルを角丸にする",
			settings_center_titles: "タイトルを中央寄せ",
			settings_enable_clockbar: "時計を有効にする",
			settings_wide_games: "ワイドゲームビュー",
			settings_wide_games_info: "各ゲームの幅を増やし、ワイド比率に合うようにアートワークの種類を変更します。",
			settings_diff_aspect: "[]",
			settings_diff_aspect_info: "[]",
			settings_show_wide_times: "プレイ時間を表示 (ワイドビュー)",
			settings_force_recent_narrow: "最近プレイしたゲームの 1 件目を縦長にする",
			settings_force_recent_narrow_info: "ワイドゲームビューが無効の場合、「最近プレイしたゲーム」に表示される 1 件目のゲームを他のゲームと同様に縦長にします。",
			settings_games_grid_rows: "画面に表示する行数 (ゲーム)",
			settings_collection_grid_rows: "画面に表示する行数 (コレクション)",
			settings_enable_touchnav: "タッチナビゲーションアイコンを有効にする",
			settings_enable_touchnav_info: "特定の画面の右上に矢印を追加し、タッチデバイスやマウスを使用している場合に戻ることができるようにします。",
			settings_more_recents: "最近プレイしたゲームの表示数を増やす",
			settings_more_recents_info: "最近プレイしたゲームの一覧に表示されるゲームの件数を 8 から 16 に増やします。",
			settings_limit_search: "前方一致検索",
			settings_limit_search_info: "検索されたテキストを含むゲームではなく、検索されたテキストで始まるゲームを検索するようにします。",
			settings_search_mode: "[]",
			settings_search_mode_info: "[]",
			settings_search_mode_regular: "[]",
			settings_search_mode_limited: "[]",
			settings_search_mode_fuzzy: "[]",
			settings_search_mode_raw: "[]",
			settings_enlarge_bar: "バーの大きさを変更",
			settings_bar_size_tiny: "極小",
			settings_bar_size_small: "小",
			settings_bar_size_medium: "中",
			settings_bar_size_large: "大",
			settings_classic_colors: "古いカラースキームを使用する",
			settings_classic_colors_info: "UI 配色をバージョン 1.2.0 以前の Library で使用されていたものに戻します。",
			settings_disable_wide_header: "ワイドビューでタイトルを表示しない",
			settings_quiet_sounds: "効果音の音量を下げる",
			settings_mute_sounds: "オーディオを消音",
			settings_video_playback: "ビデオを再生する",
			settings_blur_collects: "コレクション画像をぼかす",
			settings_change_localization: "言語を変更",
			settings_change_bg: "背景を変更",
			settings_24h_clock: "24時間時計",

			settings_header_appearance: "外観",
			settings_header_behavior: "動作",
			settings_header_av: "オーディオ & ビデオ",
			settings_header_interface: "インターフェース",
			settings_header_localization: "言語",

			playtime_never: "未プレイ",
			playtime_seconds: "秒",
			playtime_minutes: "分",
			playtime_hours: "時間",

			bottomBar_changePage: "ページを変更",
			bottomBar_aSelect: "選択",
			bottomBar_aPlay: "プレイ",
			bottomBar_aSetting: "設定を変更",
			bottomBar_bKeyboard: "キーボードを隠す",
			bottomBar_bExit: "コレクションから戻る",
			bottomBar_xKeyboard: "キーボード / バックスペース",
			bottomBar_xNext: "次のセクション",
			bottomBar_yFavorite: "お気に入り",
			bottomBar_yNext: "次へ",
			bottomBar_yKeyboard: "お気に入り / スペース",
			bottomBar_yInfo: "追加情報を表示"

		}
	}

	function getLocalization(lang) {
		return localization[lang]
	}

	function getLangs() {
		return Object.keys(localization)
	}
}
