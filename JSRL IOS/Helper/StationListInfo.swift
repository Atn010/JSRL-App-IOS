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
		case djChido = "djchidow/"
		
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
		case classicDesc = "Classic"
		case futureDesc = "Future"
		case garageDesc = "Garage"
		case ultraRemixesDesc = "Ultra Remixes"
		
		//Seasonal
		case summerDesc = "Summer"
		case christmasDesc = "Christmas"
		case halloweenDesc = "Halloween"
		case snowfiDesc = "snowfi"
		
		//Gang
		case ggsDesc = "GG's"
		case poisonJamDesc = "Poison Jam"
		case noiseTanksDesc = "Noise Tanks"
		case loveShockersDesc = "Love Shockers"
		case rapid99Desc = "Rapid 99"
		case theImmortalsDesc = "The Immortals"
		case doomRidersDesc = "Doom Riders"
		case goldenRhinosDesc = "Golden Rhinos"
		
		//Playlist
		case ganjahDesc = "Ganjah"
		case lofiDesc = "Lo-Fi"
		case chiptunesDesc = "Chiptunes"
		case retroRemixDesc = "Retro Remix"
		case classicalDesc = "Classical Remix"
		case revolutionDesc = "Revolution"
		case endOfDaysDesc = "End Of Days"
		
		//Event
		case silvaGunnerDesc = "SilvaGunner x JSR"
		case futureGenerationDesc = "Future Generation"
		case jetMashRadioDesc = "Jet Mash Radio"
		
		//Guest
		case veraFXDesc = "VeraFX"
		case djChidowDesc = "DJ Chidow"
		
		//Other Games
		case hoverDesc = "Hover"
		case butterfliesDesc = "Butterflies"
		case ollieKingDesc = "Ollie King"
		case crazyTaxiDesc = "Crazy Taxi"
		case toeJamAndEarlDesc = "Toe Jam and Earl"
		
		//Shuffle
		case shuffle = "All Stations, Ready"
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
			return Path.classic.rawValue
		case .djChidow:
			return Path.classic.rawValue
		
		case .hover: // Other Games
			return Path.classic.rawValue
		case .butterflies:
			return Path.classic.rawValue
		case .ollieKing:
			return Path.classic.rawValue
		case .crazyTaxi:
			return Path.classic.rawValue
		case .toeJamAndEarl:
			return Path.classic.rawValue
		
		
		case .shuffle: // Shuffle
			return Path.classic.rawValue
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
			logo = UIImage(named: "UltraRemix")
		
			
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
			logo = UIImage(named: "ClassicalRemix")
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
