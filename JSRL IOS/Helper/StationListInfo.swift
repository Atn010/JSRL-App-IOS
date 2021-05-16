//
//  StationListInfo.swift
//  JSRL IOS
//
//  Created by Antonius George on 27/11/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

public enum StationListInfo: String {
	
	case jetsetradio = "https://jetsetradio.live/"
	case stationPath = "radio/stations/"
	case listPath = "~list.js"
	case fileExtension = ".mp3"
	
	static let shuffleList = [
		StationListInfo.Name.classic,
		StationListInfo.Name.future,
		StationListInfo.Name.ultraRemixes,
		StationListInfo.Name.garage,
		StationListInfo.Name.summer,
		StationListInfo.Name.halloween,
		StationListInfo.Name.christmas,
		StationListInfo.Name.snowfi,
		StationListInfo.Name.ggs,
		StationListInfo.Name.poisonJam,
		StationListInfo.Name.noiseTanks,
		StationListInfo.Name.loveShockers,
		StationListInfo.Name.rapid99,
		StationListInfo.Name.theImmortals,
		StationListInfo.Name.doomRiders,
		StationListInfo.Name.goldenRhinos,
		StationListInfo.Name.ganjah,
		StationListInfo.Name.lofi,
		StationListInfo.Name.chiptunes,
		StationListInfo.Name.retroRemix,
		StationListInfo.Name.classical,
		StationListInfo.Name.revolution,
		StationListInfo.Name.endOfDays,
		StationListInfo.Name.silvaGunner,
		StationListInfo.Name.futureGeneration,
		StationListInfo.Name.jetMashRadio,
		StationListInfo.Name.veraFX,
		StationListInfo.Name.djChidow,
		StationListInfo.Name.hover,
		StationListInfo.Name.butterflies,
		StationListInfo.Name.ollieKing,
		StationListInfo.Name.crazyTaxi,
		StationListInfo.Name.toeJamAndEarl
	]
	
	// Station Playlist Path
	enum Path: String {
		//Station Bumps
		case bump = "bumps/"
		
		//Soundtrack
		case classic  = "classic/"
		case future  = "future/"
		case garage  = "garage/"
		case ultraRemixes  = "ultraremixes/"
		
		//Seasonal
		case summer  = "summer/"
		case christmas  = "christmas/"
		case halloween  = "halloween/"
		case snowfi  = "snowfi/"
		
		//Gang
		case ggs  = "ggs/"
		case poisonJam  = "poisonjam/"
		case noiseTanks  = "noisetanks/"
		case loveShockers  = "loveshockers/"
		case rapid99  = "rapid99/"
		case theImmortals  = "immortals/"
		case doomRiders  = "doomriders/"
		case goldenRhinos  = "goldenrhinos/"
		
		//Playlist
		case ganjah  = "ganjah/"
		case lofi  = "lofi/"
		case chiptunes  = "chiptunes/"
		case retroRemix  = "retroremix/"
		case classical  = "classical/"
		case revolution  = "revolution/"
		case endOfDays  = "endofdays/"
		
		//Event
		case silvaGunner = "siivagunner/"
		case futureGeneration = "futuregeneration/"
		case jetMashRadio = "jetmashradio/"
		
		//Guest
		case veraFX = "verafx/"
		case djChidow = "djchidow/"
		
		//Other Games
		case hover = "hover/"
		case butterflies = "butterflies/"
		case ollieKing = "ollieking/"
		case crazyTaxi = "crazytaxi/"
		case toeJamAndEarl = "toejamandearl/"
		
	}
	
	// Station Name
	enum Name: String {
		
		//Station Bumps
		case bump = "Bump"
		
		//Soundtrack
		case classic = "Classic"
		case future = "Future"
		case garage = "Garage"
		case ultraRemixes = "Ultra Remixes"
		
		//Seasonal
		case summer = "Summer"
		case christmas = "Christmas"
		case halloween = "Halloween"
		case snowfi = "Snow-Fi"
		
		//Gang
		case ggs = "GG's"
		case poisonJam = "Poison Jam"
		case noiseTanks = "Noise Tanks"
		case loveShockers = "Love Shockers"
		case rapid99 = "Rapid 99"
		case theImmortals = "The Immortals"
		case doomRiders = "Doom Riders"
		case goldenRhinos = "Golden Rhinos"
		
		//Playlist
		case ganjah = "Ganjah"
		case lofi = "Lo-Fi"
		case chiptunes = "Chiptunes"
		case retroRemix = "Retro Remix"
		case classical = "Classical Remix"
		case revolution = "Revolution"
		case endOfDays = "End Of Days"
		
		//Event
		case silvaGunner = "SilvaGunner x JSR"
		case futureGeneration = "Future Generation"
		case jetMashRadio = "Jet Mash Radio"
		
		//Guest
		case veraFX = "VeraFX"
		case djChidow = "DJ Chidow"
		
		//Other Games
		case hover = "Hover"
		case butterflies = "Butterflies"
		case ollieKing = "Ollie King"
		case crazyTaxi = "Crazy Taxi"
		case toeJamAndEarl = "Toe Jam and Earl"
		
		
		//Shuffle
		case shuffle = "Shuffle"
	}
	
	// Station Description
	enum Desc: String {
		//Soundtrack
		case classic = "Plays the Original Jet Set Radio soundtrack!"
		case future = "Plays the Jet Set Radio Futuresoundtrack!"
		case garage = "Nothing but chill city vibes to keep things cool."
		case ultraRemixes = "New takes on past and future classics!"
		
		//Seasonal
		case summer = "Chill vibes to keep you cool for the summer."
		case christmas = "Listen to some great tunes to get you into the holiday spirit, yo!"
		case halloween = "Get into the spooktacular spirit with these tunes!"
		case snowfi = "Relaxing & chill holday music vibes."
		
		//Gang
		case ggs = "Funky energetic beats with positive vibes!"
		case poisonJam = "Grunge rock & metal with that monster sound!"
		case noiseTanks = "Digital & electronic sounds to fry your brain!"
		case loveShockers = "Twisted, heartbroken, & love-sick ladies!"
		case rapid99 = "Upbeat & chill female tunes!"
		case theImmortals = "Ethnic music & balkan beats!"
		case doomRiders = "Biker music & classic rock!"
		case goldenRhinos = "Hip-Hop beats with deep classical rhythms of power and authority!"
		
		//Playlist
		case ganjah = "Reggae beats to chill, relax & reflect."
		case lofi = "Relaxing and chill vibes."
		case chiptunes = "Electronic music made using sound chips or synthesizers in arcade machines, computer & video game consoles."
		case retroRemix = "Past classics remixed for the future."
		case classical = "Songs of wealth, power & sophistication."
		case revolution = "The future is one big blank slate... and it's up to you to decide what goes on in it."
		case endOfDays = "Visions of the dark future that awaits if rudies fail to save the future."
		
		//Event
		case silvaGunner = "Featuring the hit tracks from the Silva Gunner KFAD Tournament (2020) & On Air Bootleg Live Stream!"
		case futureGeneration = "A JSRF-inspired tribute album with tracks by Sashko Naganuma."
		case jetMashRadio = "A mashyup compilation of Jet Set Radio tracks!!!"
		
		//Guest
		case veraFX = "Music by VefaFX"
		case djChidow = "Music by DJ Chidow"
		
		//Other Games
		case hover = "Plays the soundtrack from game."
		case butterflies = "Plays the soundtrack from the fan tribute game."
		case ollieKing = "Plays the official soundtrack from the arcade game!"
		case crazyTaxi = "Plays the crazy soundtrack from the arcade game!"
		case toeJamAndEarl = "Get `Back Into The Groove` with the official soundtrack!"
		
		//Shuffle
		case shuffle = "All Stations, Ready"
	}
	
	// Station Accent
	enum Accent {
		
		//Soundtrack
		static let  classic = UIColor.init(hexString: "FFED00")
		static let  future = UIColor.init(hexString: "949494")
		static let  garage = UIColor.init(hexString: "D8D8DA")
		static let  ultraRemixes = UIColor.init(hexString: "FFED00")
		
		//Seasonal
		static let  summer = UIColor.init(hexString: "FFE800")
		static let  christmas = UIColor.init(hexString: "82AD3A")
		static let  halloween = UIColor.init(hexString: "FF3500")
		static let  snowfi = UIColor.init(hexString: "FAABB0")
		
		
		//Gang
		static let  ggs = UIColor.init(hexString: "23E2AB")
		static let  poisonJam = UIColor.init(hexString: "00C8D8")
		static let  noiseTanks = UIColor.init(hexString: "FFFFFF")
		static let  loveShockers = UIColor.init(hexString: "00F5B0")
		static let  rapid99 = UIColor.init(hexString: "53FFD9")
		static let  theImmortals = UIColor.init(hexString: "FFDF4D")
		static let  doomRiders = UIColor.init(hexString: "BD0002")
		static let  goldenRhinos = UIColor.init(hexString: "FFF000")
		
		//Playlist
		static let ganjah = UIColor.init(hexString: "008D00")
		static let lofi = UIColor.init(hexString: "FF747F")
		static let chiptunes = UIColor.init(hexString: "0060FF")
		static let retroRemix = UIColor.init(hexString: "FFE100")
		static let classical = UIColor.init(hexString: "AC008D")
		static let revolution = UIColor.init(hexString: "FF0000")
		static let endOfDays = UIColor.init(hexString: "D76D2D")
		
		//Event
		static let silvaGunner = UIColor.init(hexString: "A3A3A3")
		static let futureGeneration = UIColor.init(hexString: "E3DCDD")
		static let jetMashRadio = UIColor.init(hexString: "1E1CAF")
		
		//Guest
		static let veraFX = UIColor.init(hexString: "56C0EF")
		static let djChidow = UIColor.init(hexString: "C73BF4")
		
		//Other Games
		static let hover = UIColor.init(hexString: "DE0056")
		static let butterflies = UIColor.init(hexString: "FA43AD")
		static let ollieKing = UIColor.init(hexString: "E5A619")
		static let crazyTaxi = UIColor.init(hexString: "FDCE00")
		static let toeJamAndEarl = UIColor.init(hexString: "FF9805")
		
		//Shuffle
		static let shuffle = UIColor.blue
	}
	
	enum Gang: String {
		case bump = "Bump"
		case soundtrack = "Soundtrack"
		case gang = "Gang"
		case seasonal = "Seasonal"
		case playlist = "Playlist"
		case event = "Event"
		case guest = "Guest"
		case otherGames = "Other Games"
		case shuffle = "Shuffle"
	}
	
	// Functions
	// Translate from station name to path
	static func getStationPath(station: StationListInfo.Name) -> String {
		switch station {
		case .bump:
			return Path.bump.rawValue
			
		case .classic: // Soundtrack
			return Path.classic.rawValue
		case .future:
			return Path.future.rawValue
		case .garage:
			return Path.garage.rawValue
		case .ultraRemixes:
			return Path.ultraRemixes.rawValue
		
			
		case .summer: // Seasonal
			return Path.summer.rawValue
		case .christmas:
			return Path.christmas.rawValue
		case .halloween:
			return Path.halloween.rawValue
		case .snowfi:
			return Path.snowfi.rawValue
		
			
		case .ggs: // Gang
			return Path.ggs.rawValue
		case .poisonJam:
			return Path.poisonJam.rawValue
		case .noiseTanks:
			return Path.noiseTanks.rawValue
		case .loveShockers:
			return Path.loveShockers.rawValue
		case .rapid99:
			return Path.rapid99.rawValue
		case .theImmortals:
			return Path.theImmortals.rawValue
		case .doomRiders:
			return Path.doomRiders.rawValue
		case .goldenRhinos:
			return Path.goldenRhinos.rawValue
		
		
		case .ganjah: // Playlist
			return Path.ganjah.rawValue
		case .lofi:
			return Path.lofi.rawValue
		case .chiptunes:
			return Path.chiptunes.rawValue
		case .retroRemix:
			return Path.retroRemix.rawValue
		case .classical:
			return Path.classical.rawValue
		case .revolution:
			return Path.revolution.rawValue
		case .endOfDays:
			return Path.endOfDays.rawValue
		
		
		case .silvaGunner: // Event
			return Path.silvaGunner.rawValue
		case .futureGeneration:
			return Path.futureGeneration.rawValue
		case .jetMashRadio:
			return Path.jetMashRadio.rawValue
		
		
		case .veraFX: // Guest
			return Path.veraFX.rawValue
		case .djChidow:
			return Path.djChidow.rawValue
		
		case .hover: // Other Games
			return Path.hover.rawValue
		case .butterflies:
			return Path.butterflies.rawValue
		case .ollieKing:
			return Path.ollieKing.rawValue
		case .crazyTaxi:
			return Path.crazyTaxi.rawValue
		case .toeJamAndEarl:
			return Path.toeJamAndEarl.rawValue
		
		
		case .shuffle: // Shuffle
			return ""
		}
	}
	
	// Translate from station name to desc
	static func getStationDesc(station: StationListInfo.Name) -> StationListInfo.Desc {
		switch station {
		case .bump:
			return .shuffle
			
		case .classic: // Soundtrack
			return Desc.classic
		case .future:
			return Desc.future
		case .garage:
			return Desc.garage
		case .ultraRemixes:
			return Desc.ultraRemixes
		
			
		case .summer: // Seasonal
			return Desc.summer
		case .christmas:
			return Desc.christmas
		case .halloween:
			return Desc.halloween
		case .snowfi:
			return Desc.snowfi
		
			
		case .ggs: // Gang
			return Desc.ggs
		case .poisonJam:
			return Desc.poisonJam
		case .noiseTanks:
			return Desc.noiseTanks
		case .loveShockers:
			return Desc.loveShockers
		case .rapid99:
			return Desc.rapid99
		case .theImmortals:
			return Desc.theImmortals
		case .doomRiders:
			return Desc.doomRiders
		case .goldenRhinos:
			return Desc.goldenRhinos
		
		
		case .ganjah: // Playlist
			return Desc.ganjah
		case .lofi:
			return Desc.lofi
		case .chiptunes:
			return Desc.chiptunes
		case .retroRemix:
			return Desc.retroRemix
		case .classical:
			return Desc.classical
		case .revolution:
			return Desc.revolution
		case .endOfDays:
			return Desc.endOfDays
		
		
		case .silvaGunner: // Event
			return Desc.silvaGunner
		case .futureGeneration:
			return Desc.futureGeneration
		case .jetMashRadio:
			return Desc.jetMashRadio
		
		
		case .veraFX: // Guest
			return Desc.veraFX
		case .djChidow:
			return Desc.djChidow
		
		case .hover: // Other Games
			return Desc.hover
		case .butterflies:
			return Desc.butterflies
		case .ollieKing:
			return Desc.ollieKing
		case .crazyTaxi:
			return Desc.crazyTaxi
		case .toeJamAndEarl:
			return Desc.toeJamAndEarl
		
		
		case .shuffle: // Shuffle
			return Desc.shuffle
		}
	}
	
	// Translate from station name to accentColor
	static func getStationAccent(station: StationListInfo.Name) -> UIColor {
		switch station {
		case .bump:
			return StationListInfo.Accent.shuffle
			
		case .classic: // Soundtrack
			return StationListInfo.Accent.classic
		case .future:
			return StationListInfo.Accent.future
		case .garage:
			return StationListInfo.Accent.garage
		case .ultraRemixes:
			return StationListInfo.Accent.ultraRemixes
		
			
		case .summer: // Seasonal
			return StationListInfo.Accent.summer
		case .christmas:
			return StationListInfo.Accent.christmas
		case .halloween:
			return StationListInfo.Accent.halloween
		case .snowfi:
			return StationListInfo.Accent.snowfi
		
			
		case .ggs: // Gang
			return StationListInfo.Accent.ggs
		case .poisonJam:
			return StationListInfo.Accent.poisonJam
		case .noiseTanks:
			return StationListInfo.Accent.noiseTanks
		case .loveShockers:
			return StationListInfo.Accent.loveShockers
		case .rapid99:
			return StationListInfo.Accent.rapid99
		case .theImmortals:
			return StationListInfo.Accent.theImmortals
		case .doomRiders:
			return StationListInfo.Accent.doomRiders
		case .goldenRhinos:
			return StationListInfo.Accent.goldenRhinos
		
		
		case .ganjah: // Playlist
			return StationListInfo.Accent.ganjah
		case .lofi:
			return StationListInfo.Accent.lofi
		case .chiptunes:
			return StationListInfo.Accent.chiptunes
		case .retroRemix:
			return StationListInfo.Accent.retroRemix
		case .classical:
			return StationListInfo.Accent.classical
		case .revolution:
			return StationListInfo.Accent.revolution
		case .endOfDays:
			return StationListInfo.Accent.endOfDays
		
		
		case .silvaGunner: // Event
			return StationListInfo.Accent.silvaGunner
		case .futureGeneration:
			return StationListInfo.Accent.futureGeneration
		case .jetMashRadio:
			return StationListInfo.Accent.jetMashRadio
		
		
		case .veraFX: // Guest
			return StationListInfo.Accent.veraFX
		case .djChidow:
			return StationListInfo.Accent.djChidow
		
		case .hover: // Other Games
			return StationListInfo.Accent.hover
		case .butterflies:
			return StationListInfo.Accent.butterflies
		case .ollieKing:
			return StationListInfo.Accent.ollieKing
		case .crazyTaxi:
			return StationListInfo.Accent.crazyTaxi
		case .toeJamAndEarl:
			return StationListInfo.Accent.toeJamAndEarl
		
		
		case .shuffle: // Shuffle
			return StationListInfo.Accent.shuffle
		}
	}
	
	// Translate from String to station name
	static func getStationName(from string: String) -> StationListInfo.Name {
		switch string {
		case StationListInfo.Name.bump.rawValue, StationListInfo.Name.bump.rawValue:
			return StationListInfo.Name.shuffle
			
		case StationListInfo.Name.classic.rawValue: // Soundtrack
			return StationListInfo.Name.classic
		case StationListInfo.Name.future.rawValue:
			return StationListInfo.Name.future
		case StationListInfo.Name.garage.rawValue:
			return StationListInfo.Name.garage
		case StationListInfo.Name.ultraRemixes.rawValue:
			return StationListInfo.Name.ultraRemixes
		
			
		case StationListInfo.Name.summer.rawValue: // Seasonal
			return StationListInfo.Name.summer
		case StationListInfo.Name.christmas.rawValue:
			return StationListInfo.Name.christmas
		case StationListInfo.Name.halloween.rawValue:
			return StationListInfo.Name.halloween
		case StationListInfo.Name.snowfi.rawValue:
			return StationListInfo.Name.snowfi
		
			
		case StationListInfo.Name.ggs.rawValue: // Gang
			return StationListInfo.Name.ggs
		case StationListInfo.Name.poisonJam.rawValue:
			return StationListInfo.Name.poisonJam
		case StationListInfo.Name.noiseTanks.rawValue:
			return StationListInfo.Name.noiseTanks
		case StationListInfo.Name.loveShockers.rawValue:
			return StationListInfo.Name.loveShockers
		case StationListInfo.Name.rapid99.rawValue:
			return StationListInfo.Name.rapid99
		case StationListInfo.Name.theImmortals.rawValue:
			return StationListInfo.Name.theImmortals
		case StationListInfo.Name.doomRiders.rawValue:
			return StationListInfo.Name.doomRiders
		case StationListInfo.Name.goldenRhinos.rawValue:
			return StationListInfo.Name.goldenRhinos
		
		
		case StationListInfo.Name.ganjah.rawValue: // Playlist
			return StationListInfo.Name.ganjah
		case StationListInfo.Name.lofi.rawValue:
			return StationListInfo.Name.lofi
		case StationListInfo.Name.chiptunes.rawValue:
			return StationListInfo.Name.chiptunes
		case StationListInfo.Name.retroRemix.rawValue:
			return StationListInfo.Name.retroRemix
		case StationListInfo.Name.classical.rawValue:
			return StationListInfo.Name.classical
		case StationListInfo.Name.revolution.rawValue:
			return StationListInfo.Name.revolution
		case StationListInfo.Name.endOfDays.rawValue:
			return StationListInfo.Name.endOfDays
		
		
		case StationListInfo.Name.silvaGunner.rawValue: // Event
			return StationListInfo.Name.silvaGunner
		case StationListInfo.Name.futureGeneration.rawValue:
			return StationListInfo.Name.futureGeneration
		case StationListInfo.Name.jetMashRadio.rawValue:
			return StationListInfo.Name.jetMashRadio
		
		
		case StationListInfo.Name.veraFX.rawValue: // Guest
			return StationListInfo.Name.veraFX
		case StationListInfo.Name.djChidow.rawValue:
			return StationListInfo.Name.djChidow
		
		case StationListInfo.Name.hover.rawValue: // Other Games
			return StationListInfo.Name.hover
		case StationListInfo.Name.butterflies.rawValue:
			return StationListInfo.Name.butterflies
		case StationListInfo.Name.ollieKing.rawValue:
			return StationListInfo.Name.ollieKing
		case StationListInfo.Name.crazyTaxi.rawValue:
			return StationListInfo.Name.crazyTaxi
		case StationListInfo.Name.toeJamAndEarl.rawValue:
			return StationListInfo.Name.toeJamAndEarl
		
		
		default:
			return StationListInfo.Name.shuffle
		}
	}
	
	// Translate from station name to image
	static func getStationImage(station: StationListInfo.Name) -> UIImage {
		
		var logo: UIImage?
		
		switch station {
		case .bump:
			logo = UIImage(named: "Classic")
			
		case .classic: // Soundtrack
			logo = UIImage(named: "Classic")
		case .future:
			logo = UIImage(named: "Future")
		case .garage:
			logo = UIImage(named: "Garage")
		case .ultraRemixes:
			logo = UIImage(named: "UltraRemixes")
		
			
		case .summer: // Seasonal
			logo = UIImage(named: "Summer")
		case .christmas:
			logo = UIImage(named: "Christmas")
		case .halloween:
			logo = UIImage(named: "Halloween")
		case .snowfi:
			logo = UIImage(named: "SnowFi")
		
			
		case .ggs: // Gang
			logo = UIImage(named: "GG's")
		case .poisonJam:
			logo = UIImage(named: "PoisonJam")
		case .noiseTanks:
			logo = UIImage(named: "NoiseTanks")
		case .loveShockers:
			logo = UIImage(named: "LoveShockers")
		case .rapid99:
			logo = UIImage(named: "Rapid99")
		case .theImmortals:
			logo = UIImage(named: "TheImmortals")
		case .doomRiders:
			logo = UIImage(named: "DoomRiders")
		case .goldenRhinos:
			logo = UIImage(named: "GoldenRhinos")
		
		
		case .ganjah: // Playlist
			logo = UIImage(named: "Ganjah")
		case .lofi:
			logo = UIImage(named: "LoFi")
		case .chiptunes:
			logo = UIImage(named: "Chiptunes")
		case .retroRemix:
			logo = UIImage(named: "RetroRemix")
		case .classical:
			logo = UIImage(named: "Classical")
		case .revolution:
			logo = UIImage(named: "Revolution")
		case .endOfDays:
			logo = UIImage(named: "EndOfDays")
		
		
		case .silvaGunner: // Event
			logo = UIImage(named: "SilvaGunner")
		case .futureGeneration:
			logo = UIImage(named: "FutureGeneration")
		case .jetMashRadio:
			logo = UIImage(named: "JetMashRadio")
		
		
		case .veraFX: // Guest
			logo = UIImage(named: "VeraFX")
		case .djChidow:
			logo = UIImage(named: "DJChidow")
		
		case .hover: // Other Games
			logo = UIImage(named: "Hover")
		case .butterflies:
			logo = UIImage(named: "Butterflies")
		case .ollieKing:
			logo = UIImage(named: "OllieKing")
		case .crazyTaxi:
			logo = UIImage(named: "CrazyTaxi")
		case .toeJamAndEarl:
			logo = UIImage(named: "ToeJamAndEarl")
		
		
		case .shuffle: // Shuffle
			logo = UIImage(named: "Shuffle")
		}
		
		
		guard let logo = logo else { return UIImage.init(named: "Preloadlogo")! }
		return logo
	}
}
