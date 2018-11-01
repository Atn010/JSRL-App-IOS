//
//  StationListCreator.swift
//  JSRL IOS
//
//  Created by Antonius George on 31/10/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class StationListCreator{
	
	struct object {
		var group:String
		var musicStation: [MusicStation]
	}
	
	
	private func prepareStations(name:String, logo:UIImage, bgColor:UIColor, acColor:UIColor) -> MusicStation{
		return MusicStation.init(name: name, logo: logo, bgLogoColor: bgColor, acLogoColor: acColor)
	}
	
	private func prepareSoundtrackStationSet() -> [MusicStation]{
		var soundtrackStationSet: [MusicStation] = []
		
		soundtrackStationSet.append(prepareStations(name: "Classic", logo: UIImage.init(named: "Classic")!, bgColor: UIColor.init(hexString: "00CA96"), acColor: UIColor.init(hexString: "FFED00") ) )
		soundtrackStationSet.append(prepareStations(name: "Future", logo: UIImage.init(named: "Future")!, bgColor: UIColor.init(hexString: "8CAFB0"), acColor: UIColor.init(hexString: "FFFFFF") ) )
		
		return soundtrackStationSet
	}
	
	private func prepareGangStationSet() -> [MusicStation]{
		var gangStationSet: [MusicStation] = []
		
		gangStationSet.append(prepareStations(name: "GG's", logo: UIImage.init(named: "GG's")!, bgColor: UIColor.init(hexString: "F8E71C"), acColor: UIColor.init(hexString: "23E2AB") ) )
		gangStationSet.append(prepareStations(name: "Poison Jam", logo: UIImage.init(named: "PoisonJam")!, bgColor: UIColor.init(hexString: "6400E5"), acColor: UIColor.init(hexString: "00C8D8") ) )
		
		gangStationSet.append(prepareStations(name: "Noise Tanks", logo: UIImage.init(named: "NoiseTanks")!, bgColor: UIColor.init(hexString: "60BEE8"), acColor: UIColor.init(hexString: "FFFFFF") ) )
		gangStationSet.append(prepareStations(name: "Love Shockers", logo: UIImage.init(named: "LoveShockers")!, bgColor: UIColor.init(hexString: "FF0086"), acColor: UIColor.init(hexString: "00F5B0") ) )
		
		gangStationSet.append(prepareStations(name: "Rapid 99", logo: UIImage.init(named: "Rapid99")!, bgColor: UIColor.init(hexString: "FF61E8"), acColor: UIColor.init(hexString: "53FFD9") ) )
		gangStationSet.append(prepareStations(name: "The Immortals", logo: UIImage.init(named: "TheImmortals")!, bgColor: UIColor.init(hexString: "9E977C"), acColor: UIColor.init(hexString: "FFDF4D") ) )
		
		gangStationSet.append(prepareStations(name: "Doom Riders", logo: UIImage.init(named: "DoomRiders")!, bgColor: UIColor.init(hexString: "8B0000"), acColor: UIColor.init(hexString: "BD0002") ) )
		gangStationSet.append(prepareStations(name: "Golden Rhinos", logo: UIImage.init(named: "GoldenRhinos")!, bgColor: UIColor.init(hexString: "000000"), acColor: UIColor.init(hexString: "FFF000") ) )
		
		return gangStationSet
	}
	
	private func prepareSeasonalStationSet() -> [MusicStation]{
		var seasonalStationSet: [MusicStation] = []
		
		seasonalStationSet.append(prepareStations(name: "Summer", logo: UIImage.init(named: "Summer")!, bgColor: UIColor.init(hexString: "00CA96"), acColor: UIColor.init(hexString: "FFE800") ) )
		seasonalStationSet.append(prepareStations(name: "Christmas", logo: UIImage.init(named: "Christmas")!, bgColor: UIColor.init(hexString: "8CAFB0"), acColor: UIColor.init(hexString: "FFFFFF") ) )
		
		return seasonalStationSet
	}
	
	func StationList() -> [object] {
		var musicList:[String:[MusicStation]] = [:]
		
			musicList["Soundtrack"] = prepareSoundtrackStationSet()
			musicList["Gang"] = prepareGangStationSet()
			musicList["Seasonal"] = prepareSeasonalStationSet()
		
		var objectArray: [object] = []
		
		objectArray.append(object.init(group: "Soundtrack", musicStation: musicList["Soundtrack"]!))
		objectArray.append(object.init(group: "Gang", musicStation: musicList["Gang"]!))
		objectArray.append(object.init(group: "Seasonal", musicStation: musicList["Seasonal"]!))
		/*
		for (key, value) in musicList{
			objectArray.append(object.init(group: key, musicStation: value))
		}
		*/
		return objectArray
	}
	
}
