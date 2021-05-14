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
		soundtrackStationSet.append(prepareStations(name: .ultraRemixes))
		soundtrackStationSet.append(prepareStations(name: .garage))
		
		return soundtrackStationSet
	}
	
	private func prepareGangStationSet() -> [MusicStation]{
		var gangStationSet: [MusicStation] = []
		
		gangStationSet.append(prepareStations(name: .ggs))
		gangStationSet.append(prepareStations(name: .noiseTanks))
		
		gangStationSet.append(prepareStations(name: .poisonJam))
		gangStationSet.append(prepareStations(name: .rapid99))
		
		gangStationSet.append(prepareStations(name: .loveShockers))
		gangStationSet.append(prepareStations(name: .theImmortals))
		
		gangStationSet.append(prepareStations(name: .doomRiders))
		gangStationSet.append(prepareStations(name: .goldenRhinos))
		
		return gangStationSet
	}
	
	private func preparePlaylistStationSet() -> [MusicStation]{
		var playlistStationSet: [MusicStation] = []
		
		playlistStationSet.append(prepareStations(name: .ganjah))
		playlistStationSet.append(prepareStations(name: .lofi))
		
		playlistStationSet.append(prepareStations(name: .chiptunes))
		playlistStationSet.append(prepareStations(name: .retroRemix))
		
		playlistStationSet.append(prepareStations(name: .classical))
		playlistStationSet.append(prepareStations(name: .revolution))
		
		playlistStationSet.append(prepareStations(name: .endOfDays))
		
		return playlistStationSet
	}
	
	
	private func prepareEventStationSet() -> [MusicStation]{
		var eventStationSet: [MusicStation] = []
		
		eventStationSet.append(prepareStations(name: .silvaGunner))
		eventStationSet.append(prepareStations(name: .futureGeneration))
		eventStationSet.append(prepareStations(name: .jetMashRadio))
		
		return eventStationSet
	}
	
	private func prepareGuestStationSet() -> [MusicStation]{
		var guestStationSet: [MusicStation] = []
		
		guestStationSet.append(prepareStations(name: .veraFX))
		guestStationSet.append(prepareStations(name: .djChidow))
		
		return guestStationSet
	}
	
	private func prepareGameStationSet() -> [MusicStation]{
		var gameStationSet: [MusicStation] = []
		
		gameStationSet.append(prepareStations(name: .hover))
		gameStationSet.append(prepareStations(name: .butterflies))
		gameStationSet.append(prepareStations(name: .ollieKing))
		gameStationSet.append(prepareStations(name: .crazyTaxi))
		gameStationSet.append(prepareStations(name: .toeJamAndEarl))
		
		return gameStationSet
	}
	
	private func prepareSeasonalStationSet() -> [MusicStation]{
		var seasonalStationSet: [MusicStation] = []
		
		seasonalStationSet.append(prepareStations(name: .summer))
		seasonalStationSet.append(prepareStations(name: .halloween))
		seasonalStationSet.append(prepareStations(name: .christmas))
		seasonalStationSet.append(prepareStations(name: .snowfi))
		
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
		musicList[StationListInfo.Gang.playlist.rawValue] = preparePlaylistStationSet()
		musicList[StationListInfo.Gang.event.rawValue] = prepareEventStationSet()
		musicList[StationListInfo.Gang.guest.rawValue] = prepareGuestStationSet()
		musicList[StationListInfo.Gang.otherGames.rawValue] = prepareGameStationSet()
			musicList[StationListInfo.Gang.shuffle.rawValue] = prepareShuffleStationSet()
		
		var objectArray: [object] = []
		
		objectArray.append(object.init(group: StationListInfo.Gang.soundtrack.rawValue, musicStation: musicList[StationListInfo.Gang.soundtrack.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.gang.rawValue, musicStation: musicList[StationListInfo.Gang.gang.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.seasonal.rawValue, musicStation: musicList[StationListInfo.Gang.seasonal.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.playlist.rawValue, musicStation: musicList[StationListInfo.Gang.playlist.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.event.rawValue, musicStation: musicList[StationListInfo.Gang.event.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.guest.rawValue, musicStation: musicList[StationListInfo.Gang.guest.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.otherGames.rawValue, musicStation: musicList[StationListInfo.Gang.otherGames.rawValue]!))
		objectArray.append(object.init(group: StationListInfo.Gang.shuffle.rawValue, musicStation: musicList[StationListInfo.Gang.shuffle.rawValue]!))
		return objectArray
	}
	
}
