import QtQuick 2.8
import QtMultimedia 5.9
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

FocusScope {

	/* A tool to convert Launchbox items to actual counterparts
	 * Directly from neoretrō: https://github.com/valsou/neoretro
	 * Used in GICusart.
	 */

	function clearShortname(shortname) {
		return dataLaunchbox[shortname] ? dataLaunchbox[shortname] : shortname
	}

	property variant dataLaunchbox: {
		"amstrad cpc" :                             "amstradcpc",
		"apple ii" :                                "apple2",
		"atari 2600" :                              "atari2600",
		"atari 5200" :                              "atari5200",
		"atari st" :                                "atarist",
		"atari 7800" :                              "atari7800",
		"atari lynx" :                              "atarilynx",
		"atari jaguar" :                            "atarijaguar",
		"capcom cps1" :                             "cps1",
		"capcom cps2" :                             "cps2",
		"capcom cps3" :                             "cps3",
		"commodore 64" :                            "c64",
		"commodore amiga" :                         "amiga",
		"mattel intellivision" :                    "intellivision",
		"microsoft msx" :                           "msx",
		"microsoft msx2" :                          "msx2",
		"nec turbografx-16" :                       "turbografx16",
		"pc engine supergrafx" :                    "supergrafx",
		"nec pc-fx" :                               "pcfx",
		"nintendo entertainment system" :           "nes",
		"nintendo famicom disk system" :            "fds",
		"nintendo virtual boy" :                    "virtualboy",
		"nintendo game boy" :                       "gb",
		"super nintendo entertainment system" :     "snes",
		"nintendo 64" :                             "n64",
		"nintendo game boy color" :                 "gbc",
		"nintendo game boy advance" :               "gba",
		"nintendo gamecube" :                       "gc",
		"nintendo ds" :                             "nds",
		"nintendo wii" :                            "wii",
		"nintendo 3ds" :                            "3ds",
		"nintendo wii u" :                          "wiiu",
		"nintendo switch" :                 		"switch",
		"3do interactive multiplayer" :             "3do",
		"sammy atomiswave" :                        "atomiswave",
		"scummvm" :                      			"scumm",
		"sega master system" :                      "mastersystem",
		"sega genesis" :                            "genesis",
		"sega mega drive" :                         "megadrive",
		"sega game gear" :                          "gamegear",
		"sega cd" :                                 "segacd",
		"sega 32x" :                                "sega32x",
		"sega saturn" :                             "saturn",
		"sega dreamcast" :                          "dreamcast",
		"sinclair zx spectrum" :                    "zxspectrum",
		"gce vectrex" :                             "vectrex",
		"snk neo geo aes" :                         "neogeo",
		"snk neo geo mvs":                          "neogeo",
		"snk neo geo cd" :                          "neogeocd",
		"snk neo geo pocket" :                      "ngp",
		"snk neo geo pocket color" :                "ngpc",
		"sony playstation" :                        "psx",
		"sony playstation 2" :                      "ps2",
		"sony playstation 3" :                      "ps3",
		"sony psp" :                                "psp",
		"final burn alpha" :                        "fba",
		"final burn neo" :                          "fbneo"
	}
}
