//
//  StationListInfo.swift
//  JSRL IOS
//
//  Created by Antonius George on 27/11/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class StationListInfo{
	
	
	let jetsetradio = "https://jetsetradio.live/"
	let stationPath = "radio/stations/"
	let listPath = "~list.js"
	let fileExtension = ".mp3"
	
	// Station Playlist Path
	//Station Bumps
	let bumpPath = "bumps/"
	
	//Soundtrack
	let classicPath = "classic/"
	let futurePath = "future/"
	
	//Seasonal
	let summerPath = "summer/"
	let christmasPath = "christmas/"
	
	//Gang
	let ggsPath = "ggs/"
	let poisonJamPath = "poisonjam/"
	let noiseTanksPath = "noisetanks/"
	let loveShockersPath = "loveshockers/"
	let rapid99Path = "rapid99/"
	let theImmortalsPath = "immortals/"
	let doomRidersPath = "doomriders/"
	let goldenRhinosPath = "goldenrhinos/"
	
	
	// Station Name
	//Station Bumps
	let bump = "Bump"
	
	//Soundtrack
	let classic = "Classic"
	let future = "Future"
	
	//Seasonal
	let summer = "Summer"
	let christmas = "Christmas"
	
	//Gang
	let ggs = "GG's"
	let poisonJam = "Poison Jam"
	let noiseTanks = "Noise Tanks"
	let loveShockers = "Love Shockers"
	let rapid99 = "Rapid 99"
	let theImmortals = "The Immortals"
	let doomRiders = "Doom Riders"
	let goldenRhinos = "Golden Rhinos"
	
	
	// Functions
	// Translate from station to path
	func getStationPath(station:String) -> String {
		
		if station == bump{
			return bumpPath
		}
			
		else if station == classic{
			return classicPath
		}else if station == future{
			return futurePath
		}else if station == summer{
			return summerPath
		}else if station == christmas{
			return christmasPath
		}
			
			
		else if station == ggs{
			return ggsPath
		}else if station == poisonJam{
			return poisonJamPath
		}else if station == noiseTanks{
			return noiseTanksPath
		}else if station == loveShockers{
			return loveShockersPath
		}
			
		else if station == rapid99{
			return rapid99Path
		}else if station == theImmortals{
			return theImmortalsPath
		}else if station == doomRiders{
			return doomRidersPath
		}else if station == goldenRhinos{
			return goldenRhinosPath
		}
		
		return ""
	}
	
	// Translate from station to path
	func getStationImage(station:String) -> UIImage {
		
		var logo:UIImage = UIImage.init(named: "Preloadlogo")!
		
		if station == bump{
			logo = UIImage(named: "Classic")!
		}
			
		else if station == classic{
			logo = UIImage(named: "Classic")!
		}else if station == future{
			logo = UIImage(named: "Future")!
		}else if station == summer{
			logo = UIImage(named: "Summer")!
		}else if station == christmas{
			logo = UIImage(named: "Christmas")!
		}
			
			
		else if station == ggs{
			logo = UIImage(named: "GG's")!
		}else if station == poisonJam{
			logo = UIImage(named: "PoisonJam")!
		}else if station == noiseTanks{
			logo = UIImage(named: "NoiseTanks")!
		}else if station == loveShockers{
			logo = UIImage(named: "LoveShockers")!
		}
			
		else if station == rapid99{
			logo = UIImage(named: "Rapid99")!
		}else if station == theImmortals{
			logo = UIImage(named: "TheImmortals")!
		}else if station == doomRiders{
			logo = UIImage(named: "DoomRiders")!
		}else if station == goldenRhinos{
			logo = UIImage(named: "GoldenRhinos")!
		}
		
		else if station == "Shuffle"{
			logo = UIImage(named: "Shuffle")!
		}
		
		
		return logo
	}
}
