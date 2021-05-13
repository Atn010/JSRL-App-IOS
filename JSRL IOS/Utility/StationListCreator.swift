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
	
	
	private func prepareStations(name: StationListInfo.Name) -> MusicStation{
		return MusicStation.init(
			name: name,
			desc: StationListInfo.getStationDesc(station: name),
			logo: StationListInfo.getStationImage(station: name),
			accent: StationListInfo.getStationAccent(station: name))
	}
	
	private func prepareSoundtrackStationSet() -> [MusicStation]{
		var soundtrackStationSet: [MusicStation] = []
		
		soundtrackStationSet.append(prepareStations(name: .classic))
		soundtrackStationSet.append(prepareStations(name: .future))
		
		return soundtrackStationSet
	}
	
	private func prepareGangStationSet() -> [MusicStation]{
		var gangStationSet: [MusicStation] = []
		
		gangStationSet.append(prepareStations(name: .ggs))
		gangStationSet.append(prepareStations(name: .poisonJam))
		
		gangStationSet.append(prepareStations(name: .noiseTanks))
		gangStationSet.append(prepareStations(name: .loveShockers))
		
		gangStationSet.append(prepareStations(name: .rapid99))
		gangStationSet.append(prepareStations(name: .theImmortals))
		
		gangStationSet.append(prepareStations(name: .doomRiders))
		gangStationSet.append(prepareStations(name: .goldenRhinos))
		
		return gangStationSet
	}
	
	private func prepareSeasonalStationSet() -> [MusicStation]{
		var seasonalStationSet: [MusicStation] = []
		
		seasonalStationSet.append(prepareStations(name: .summer))
		seasonalStationSet.append(prepareStations(name: .christmas))
		
		return seasonalStationSet
	}
	
	private func prepareShuffleStationSet() -> [MusicStation]{
		var shuffleStationSet: [MusicStation] = []
		
		shuffleStationSet.append(prepareStations(name: .shuffle))
		
		return shuffleStationSet
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
