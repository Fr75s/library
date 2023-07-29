import QtQuick 2.8

// Custom Font for icons
FontLoader {
	id: icons;

	property string allgames: '\ue800';
	property string nav_collections: '\ue801';
	property string nav_feed: '\ue802';
	property string nav_home: '\ue803';
	property string nav_search: '\ue804';
	property string nav_settings: '\ue805';
	property string touch_up: '\ue806';
	property string input_universal_a: '\ue807';
	property string input_universal_x: '\ue808';
	property string input_universal_lb: '\ue809';
	property string input_universal_lt: '\ue80a';
	property string input_universal_b: '\ue80b';
	property string input_universal_rb: '\ue80c';
	property string input_universal_rt: '\ue80d';
	property string input_universal_y: '\ue80e';
	property string input_xbox_a: '\ue80f';
	property string input_xbox_x: '\ue810';
	property string input_xbox_lb: '\ue811';
	property string input_xbox_lt: '\ue812';
	property string input_xbox_b: '\ue813';
	property string input_xbox_rb: '\ue814';
	property string input_xbox_rt: '\ue815';
	property string input_xbox_y: '\ue816';
	property string input_ps_a: '\ue817';
	property string input_ps_x: '\ue818';
	property string input_ps_lb: '\ue819';
	property string input_ps_lt: '\ue81a';
	property string input_ps_b: '\ue81b';
	property string input_ps_rb: '\ue81c';
	property string input_universal_start: '\ue81d';
	property string input_universal_select: '\ue81e';
	property string input_xbox_start: '\ue81f';
	property string input_xbox_select: '\ue820';
	property string input_ps_rt: '\ue821';
	property string input_ps_y: '\ue822';
	property string input_ps_start: '\ue823';
	property string input_ps_select: '\ue824';
	property string star: '\ue825';
	property string star_empty: '\ue826';
	property string meta_date: '\ue827';
	property string meta_dev: '\ue828';
	property string meta_genre: '\ue829';
	property string meta_publisher: '\ue82a';
	property string meta_players: '\ue82b';
	property string battery_0: '\ue82c';
	property string battery_10: '\ue82d';
	property string battery_20: '\ue82e';
	property string battery_30: '\ue82f';
	property string battery_40: '\ue830';
	property string battery_50: '\ue831';
	property string battery_60: '\ue832';
	property string battery_70: '\ue833';
	property string battery_80: '\ue834';
	property string battery_90: '\ue835';
	property string battery_100: '\ue836';
	property string battery_charging: '\ue837';
	property string input_nintendo_zl: '\ue83b';
	property string input_nintendo_zr: '\ue83c';
	property string input_sd_l2: '\ue83d';
	property string input_sd_r2: '\ue83e';
	property string input_sd_l1: '\ue83f';
	property string input_sd_r1: '\ue840';
	property string input_nintendo_l: '\ue841';
	property string input_nintendo_r: '\ue842';
	property string input_sd_select: '\ue843';
	property string input_sd_start: '\ue844';
	property string input_nintendo_sl: '\ue845';
	property string input_nintendo_sr: '\ue846';
	property string star_half: '\uf123';
	property string toggle_off: '\uf204';
	property string toggle_on: '\uf204';

	// Button schemes
	property var btnScheme: {
		"universal": {
			A: icons.input_universal_a,
			X: icons.input_universal_x,
			L1: icons.input_universal_lb,
			L2: icons.input_universal_lt,
			B: icons.input_universal_b,
			R1: icons.input_universal_rb,
			R2:icons.input_universal_rt,
			Y: icons.input_universal_y,
			Start: icons.input_universal_start,
			Select: icons.input_universal_select
		},
		"universal_jp": {
			A: icons.input_universal_b,
			X: icons.input_universal_y,
			L1: icons.input_universal_lb,
			L2: icons.input_universal_lt,
			B: icons.input_universal_a,
			R1: icons.input_universal_rb,
			R2:icons.input_universal_rt,
			Y: icons.input_universal_x,
			Start: icons.input_universal_start,
			Select: icons.input_universal_select
		},
		"xbox": {
			A: icons.input_xbox_a,
			X: icons.input_xbox_x,
			L1: icons.input_xbox_lb,
			L2: icons.input_xbox_lt,
			B: icons.input_xbox_b,
			R1: icons.input_xbox_rb,
			R2:icons.input_xbox_rt,
			Y: icons.input_xbox_y,
			Start: icons.input_xbox_start,
			Select: icons.input_xbox_select
		},
		"ps": {
			A: icons.input_ps_a,
			X: icons.input_ps_x,
			L1: icons.input_ps_lb,
			L2: icons.input_ps_lt,
			B: icons.input_ps_b,
			R1: icons.input_ps_rb,
			R2:icons.input_ps_rt,
			Y: icons.input_ps_y,
			Start: icons.input_ps_start,
			Select: icons.input_ps_select
		},
		"ps_jp": {
			A: icons.input_ps_b,
			X: icons.input_ps_y,
			L1: icons.input_ps_lb,
			L2: icons.input_ps_lt,
			B: icons.input_ps_a,
			R1: icons.input_ps_rb,
			R2:icons.input_ps_rt,
			Y: icons.input_ps_x,
			Start: icons.input_ps_start,
			Select: icons.input_ps_select
		},
		"nintendo": {
			A: icons.input_xbox_a,
			X: icons.input_xbox_x,
			L1: icons.input_nintendo_l,
			L2: icons.input_nintendo_zl,
			B: icons.input_xbox_b,
			R1: icons.input_nintendo_r,
			R2:icons.input_nintendo_zr,
			Y: icons.input_xbox_y,
			Start: icons.input_universal_start,
			Select: icons.input_universal_select
		},
		"steam_deck": {
			A: icons.input_xbox_a,
			X: icons.input_xbox_x,
			L1: icons.input_sd_l1,
			L2: icons.input_sd_l2,
			B: icons.input_xbox_b,
			R1: icons.input_sd_r1,
			R2:icons.input_sd_r2,
			Y: icons.input_xbox_y,
			Start: icons.input_sd_start,
			Select: icons.input_sd_select
		}
	}

	// This list needs to be separate to allow for customization of order, rather than going
	// by each key alphabetically in the convert object
	property var btnSchemeOrder: {0: "universal", 1: "universal_jp", 2: "xbox", 3: "ps", 4: "ps_jp", 5: "nintendo", 6: "steam_deck"}
	// Converts the indexes in btnScheme to the names that are displayed
	// This makes it so that what's displayed is possible to customize and localize
	property var btnNameConvert: {
		"universal": "universal",
		"universal_jp": "universal JP",
		"xbox": "xbox",
		"ps": "playstation",
		"ps_jp": "playstation JP",
		"nintendo": "nintendo",
		"steam_deck": "steam deck"
	}

	source: "../assets/font/library-icons.woff2";
}
