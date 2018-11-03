//
//  MusicPlayerObject.swift
//  JSRL IOS
//
//  Created by Antonius George on 01/11/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class MusicPlayerObject: NSObject{
	
	var currentTrack = ""
	var progress:Float = 0.0
	var isAudioPlayerPlaying = false
	
	
	
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
	
	
	static let shared = MusicPlayerObject()
	let t = RepeatingTimer(timeInterval: TimeInterval.init(exactly: 0.1)!)
	var audioPlayer =  AVQueuePlayer()
	var staticPlayer = AVAudioPlayer()
	var playerItems: [AVPlayerItem] = []
	var musicPlayer = AVPlayer()
	var index = 0
	
	var loadingNextItem = false
	var nextItem:AVPlayerItem?
	var nextItemisLoaded = false
	
	override private init() {
		do {
			UIApplication.shared.beginReceivingRemoteControlEvents()
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
		
			do {
				try AVAudioSession.sharedInstance().setActive(true)
				UIApplication.shared.beginReceivingRemoteControlEvents()
				print("AVAudioSession is Active")
			} catch let error as NSError {
				print(error.localizedDescription)
			}
			try staticPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "static", ofType: "mp3")!))
			staticPlayer.numberOfLoops = -1
		} catch {
			print("Failed to set audio session category.  Error: \(error.localizedDescription)")
		}
	}
	
	func initializeMusicChecker(){
		t.eventHandler = {
			self.musicProgressChecker()
		}
		
		t.resume()
	}
	func musicProgressChecker(){
		if currentTrack != "" || currentTrack != "Loading"{
			guard let currentTime = musicPlayer.currentItem?.currentTime() else{return}
			guard let totalTime = musicPlayer.currentItem?.duration else{return}
			
			let current = CMTimeGetSeconds(currentTime)
			let total = CMTimeGetSeconds(totalTime)
			
			progress = Float(current / total)
			if progress >= 0.99{
				playNextItem()
			}
			
		}
		
		
		//print("Audioplayer: \(audioPlayer.items().count) - \(audioPlayer.items().isEmpty)")
		if playerItems.count == 0{
			if staticPlayer.isPlaying == false{
				staticPlayer.play()
			}
		}
		
	}
	
	func playNextItem(){
		currentTrack = "Loading"
		if index + 1 >= playerItems.count{
			isAudioPlayerPlaying = false
			playerItems.removeAll()
			index = 0
		}else{
			index += 1
			guard let nextPlayerItem:AVPlayerItem = playerItems[index] else{
				index = 9999
				playNextItem()
			}
			
			musicPlayer = AVPlayer(playerItem: nextPlayerItem)
			
			guard let itemURL = musicPlayer.currentItem?.asset as? AVURLAsset else{return}
			
				currentTrack = itemURL.url.lastPathComponent
				currentTrack.removeLast(4)
			print(currentTrack)
			musicPlayer.rate = 1
			musicPlayer.automaticallyWaitsToMinimizeStalling = false
			musicPlayer.play()

		}
	}
	
	func bufferNextItem(){
		
	}
	
	func playMusic(station:String){
		
		playerItems = playListMaker(stationSelected: station)
		index = 0
		if playerItems.count > 0{
			musicPlayer = AVPlayer(playerItem: playerItems[index])
			
			musicPlayer.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial] , context: nil)
			musicPlayer.addObserver(self, forKeyPath: "rate", options: [.new, .initial], context: nil)

			musicPlayer.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 600), queue: DispatchQueue.main, using: { time in
				
				if self.musicPlayer.currentItem?.status == AVPlayerItem.Status.readyToPlay {
					
					if self.staticPlayer.isPlaying{
						self.staticPlayer.stop()
					}
					if (self.musicPlayer.currentItem?.isPlaybackBufferFull) != nil{
						// something here to Load next item
						//bufferNextItem()
						
					}
					
				}else{
					if !self.staticPlayer.isPlaying{
						self.staticPlayer.play()
					}
					//print("Not Ready yet")
				}
			})
			
			musicPlayer.rate = 1
			musicPlayer.automaticallyWaitsToMinimizeStalling = false
			musicPlayer.play()
			isAudioPlayerPlaying = true
		}
		
	}
	
	func requestAuth() {
		
		MPMediaLibrary.requestAuthorization { (authStatus) in
			switch authStatus {
			case .notDetermined:
				self.requestAuth()
				break
			case .authorized:
				//self.querySongs()
				break
			default:
				//self.displayPermissionsError()
				break
				
			}
		}
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
	
		if keyPath == "currentItem",
			let player = object as? AVPlayer,
			let currentItem = player.currentItem?.asset as? AVURLAsset {
			
			currentTrack = currentItem.url.lastPathComponent
			currentTrack.removeLast(4)
		}
	}
	
	
	private func playListMaker(stationSelected:String) -> [AVPlayerItem]{
		var playList = stationPlayListRetriever(stationSelected: stationSelected)
		playList.shuffle()
		
		var bumpSet = stationPlayListRetriever(stationSelected: bump)
		//bumpSet.shuffle()
		
		var counting = 0
		var itemCount = 0
		var randomInterval = Int.random(in: 3 ... 5)
		
		playList.insert(bumpSet[Int.random(in: 0 ... 48)], at: 0)
		while itemCount < playList.count {
			counting += 1
			if counting == randomInterval{
				
				playList.insert(bumpSet[Int.random(in: 0 ... 48)], at: itemCount)
				//print(playList[itemCount])
				counting = 0
				randomInterval = Int.random(in: 3 ... 5)
			}
			
			itemCount+=1
		}
		

		return playList
	}
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
			return theImmortals
		}		else if station == doomRiders{
			return doomRidersPath
		}else if station == goldenRhinos{
			return goldenRhinosPath
		}
		
		return ""
	}
	
	private func stationPlayListRetriever(stationSelected:String) -> [AVPlayerItem]{
		let jetsetradio = "https://jetsetradio.live/"
		let stationPath = "audioplayer/stations/"
		let fileExtension = ".mp3"
		let station = getStationPath(station: stationSelected)
		
		var stationPlayList: [AVPlayerItem] = []
		//var musicList: [String] = []
		if station != ""{
			
			
			if let list = UserDefaults.standard.stringArray(forKey: stationSelected) {
				print(stationSelected)
				list.forEach { (item) in
					
					let stringURL = jetsetradio + stationPath + station + item + fileExtension
					//print(stringURL)
					if let readyString = stringURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
						if let validURL = URL(string: readyString){
							//print(validURL)
							
							let playItem = AVPlayerItem.init(url: validURL)

							stationPlayList.append(playItem)
							return
						}
					}
				}
			}
		}

		
		return stationPlayList
	}
	
	
}
