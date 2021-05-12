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
	
	
	private func prepareStations(name: StationListInfo.Name, desc: StationListInfo.Desc, accent: UIColor) -> MusicStation{
		return MusicStation.init(name: name, desc: desc, logo: StationListInfo.getStationImage(station: name), accent: accent)
	}
	
	private func prepareSoundtrackStationSet() -> [MusicStation]{
		var soundtrackStationSet: [MusicStation] = []
		
		soundtrackStationSet.append(prepareStations(name: .classic, desc: .classicDesc, accent: UIColor.init(hexString: "FFED00")))
		soundtrackStationSet.append(prepareStations(name: .future, desc: .futureDesc, accent: UIColor.init(hexString: "FFFFFF") ) )
		
		return soundtrackStationSet
	}
	
	private func prepareGangStationSet() -> [MusicStation]{
		var gangStationSet: [MusicStation] = []
		
		gangStationSet.append(prepareStations(name: .ggs, desc: .ggsDesc, accent: UIColor.init(hexString: "23E2AB") ) )
		gangStationSet.append(prepareStations(name: .poisonJam, desc: .poisonJamDesc, accent: UIColor.init(hexString: "00C8D8") ) )
		
		gangStationSet.append(prepareStations(name: .noiseTanks, desc: .noiseTanksDesc, accent: UIColor.init(hexString: "FFFFFF") ) )
		gangStationSet.append(prepareStations(name: .loveShockers, desc: .classicDesc, accent: UIColor.init(hexString: "00F5B0") ) )
		
		gangStationSet.append(prepareStations(name: .rapid99, desc: .rapid99Desc, accent: UIColor.init(hexString: "53FFD9") ) )
		gangStationSet.append(prepareStations(name: .theImmortals, desc: .theImmortalsDesc , accent: UIColor.init(hexString: "FFDF4D") ) )
		
		gangStationSet.append(prepareStations(name: .doomRiders, desc: .doomRidersDesc , accent: UIColor.init(hexString: "BD0002") ) )
		gangStationSet.append(prepareStations(name: .goldenRhinos, desc: .goldenRhinosDesc, accent: UIColor.init(hexString: "FFF000") ) )
		
		return gangStationSet
	}
	
	private func prepareSeasonalStationSet() -> [MusicStation]{
		var seasonalStationSet: [MusicStation] = []
		
		seasonalStationSet.append(prepareStations(name: .summer, desc: .summerDesc, accent: UIColor.init(hexString: "FFE800") ) )
		seasonalStationSet.append(prepareStations(name: .christmas, desc: .christmasDesc, accent: UIColor.init(hexString: "D70000") ) )
		
		return seasonalStationSet
	}
	
	private func prepareShuffleStationSet() -> [MusicStation]{
		var seasonalStationSet: [MusicStation] = []
		
		seasonalStationSet.append(prepareStations(name: .shuffle, desc: .shuffle, accent: UIColor.blue ) )
		
		return seasonalStationSet
	}
	
	func StationList() -> [object] {
		var musicList:[String:[MusicStation]] = [:]
		
			musicList[StationListInfo.Gang.soundtrack.rawValue] = prepareSoundtrackStationSet()
			musicList[StationListInfo.Gang.gang.rawValue] = prepareGangStationSet()
			musicList[StationListInfo.Gang.seasonal.rawValue] = prepareSeasonalStationSet()
			musicList[StationListInfo.Gang.shuffle.rawValue] = prepareShuffleStationSet()
		
		var objectArray: [object] = []
		
		objectArray.append(object.init(group: StationListInfo.Gang.soundtrack.rawValue, musicStation: musicList[StationListInfo.Gang.soundtrack.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.gang.rawValue, musicStation: musicList[StationListInfo.Gang.gang.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.seasonal.rawValue, musicStation: musicList[StationListInfo.Gang.seasonal.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.shuffle.rawValue, musicStation: musicList[StationListInfo.Gang.shuffle.rawValue]!))
		/*
		for (key, value) in musicList{
			objectArray.append(object.init(group: key, musicStation: value))
		}
		*/
		return objectArray
	}
	
}
