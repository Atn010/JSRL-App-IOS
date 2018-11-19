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
	
	let jetsetradio = "https://jetsetradio.live/"
	let stationPath = "audioplayer/stations/"
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
	
	var logo:UIImage = UIImage.init(named: "Preloadlogo")!
	
	var loadingNextItem = false
	var nextItem:AVPlayerItem?
	var nextItemisLoaded = false
	
	// MARK: - Init
	// Register Audio Session
	// Initialize Static Player
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
	
	// MARK: - Background Checker
	// Initialize Background Checking Object
	func initializeMusicChecker(){
		initialiseMediaRemote()
		t.eventHandler = {
			self.musicProgressChecker()
		}
		
		t.resume()
	}
	// Checks the progress of music in background, and update to this object
	func musicProgressChecker(){
		if currentTrack != "" || currentTrack != "Loading"{
			guard let currentTime = musicPlayer.currentItem?.currentTime() else{return}
			guard let totalTime = musicPlayer.currentItem?.duration else{return}
			
			let current = CMTimeGetSeconds(currentTime)
			let total = CMTimeGetSeconds(totalTime)
			
			progress = Float(current / total)
			
			// Plays Next Music when completed
			/*
			if progress >= 0.999{
				playNextItem()
			}
			*/
		}
		
		
		// Plays Static player when player item is empty
		if playerItems.count == 0{
			if staticPlayer.isPlaying == false{
				staticPlayer.play()
			}
		}
		
	}
	
	// MARK: - Play Next Media Item
	func playNextItem(){
		//musicPlayer.removeTimeObserver(self)
		//musicPlayer.seek(to: kCMTimeZero)
		musicPlayer.pause()
		
		//musicPlayer.currentItem?.asset.cancelLoading()
		//musicPlayer.currentItem?.cancelPendingSeeks()
		//musicPlayer.seek(to: kCMTimeZero)
		/*
		musicPlayer.seek(to: kCMTimeZero) { (bol) in
		self.musicPlayer.pause()
		}
		*/
		
		// Switch state to Loading
		currentTrack = "Loading"
		if !self.staticPlayer.isPlaying{
			self.staticPlayer.play()
		}
		// Checks if Next item isn't index out of bound
		if index + 1 >= playerItems.count{
			isAudioPlayerPlaying = false
			playerItems.removeAll()
			index = 0
		}else{
			index += 1
			
			// Check if player item in the next index Exists
			if !playerItems.indices.contains(index){
				print("Not")
				index = 9999
				playNextItem()
				
			}else{
				
				if !self.staticPlayer.isPlaying{
					//print("Playing Static")
					self.staticPlayer.play()
				}
				self.musicPlayer.pause()
				// Restart Music Player to Zero
				musicPlayer.seek(to: kCMTimeZero) { (bol) in
					// On Completion:
					self.musicPlayer.pause()
					if !self.staticPlayer.isPlaying{
						//print("Playing Static")
						self.staticPlayer.play()
					}
					
					let nextPlayerItem:AVPlayerItem = self.playerItems[self.index]
					
					// Remove previous item
					self.playerItems.remove(at: self.index - 1)
					//musicPlayer.seek(to: kCMTimeZero)
					self.musicPlayer.replaceCurrentItem(with: nextPlayerItem)
					//self.musicPlayer.currentItem?.canUseNetworkResourcesForLiveStreamingWhilePaused = true
					
					// Show updated Music Track name to User
					guard let itemURL = self.musicPlayer.currentItem?.asset as? AVURLAsset else{return}
					
					self.currentTrack = itemURL.url.lastPathComponent
					self.currentTrack.removeLast(4)
					print("\(self.index)/\(self.playerItems.count) ~ \(Date()) ~ \(self.currentTrack)")
					self.updateMediaRemoteState()
					self.musicPlayer.play()
				}
				
				
			}
		}
	}
	
	func bufferNextItem(){
		// TODO
		

	}
	
	// MARK: - Initialize Music Player
	func playMusic(station:[String]){
		// Restart Music player
		musicPlayer.pause()
		if !self.staticPlayer.isPlaying{
			self.staticPlayer.play()
		}
		
		playerItems = playListMaker(stationSelected: station)
		index = 0
		if playerItems.count > 0{
			musicPlayer = AVPlayer(playerItem: playerItems[index])
			
			//musicPlayer.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial] , context: nil)
			//musicPlayer.addObserver(self, forKeyPath: "rate", options: [.new, .initial], context: nil)
			
			// Adds Observer over time.
			musicPlayer.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 600), queue: DispatchQueue.main, using: { time in
				
				if self.musicPlayer.timeControlStatus == AVPlayerTimeControlStatus.paused{
					self.isAudioPlayerPlaying = false
				}else{
					self.isAudioPlayerPlaying = true
				}
				
				
				if self.musicPlayer.currentItem?.status == AVPlayerItem.Status.readyToPlay {
					if self.staticPlayer.isPlaying{
						//print("Stopping Static Player")
						self.musicPlayer.play()
						self.staticPlayer.stop()
					}
					/*
					guard let playbackIsKeepUp = self.musicPlayer.currentItem?.isPlaybackLikelyToKeepUp else {return}
					print("K: \(playbackIsKeepUp)")
					
					guard let playbackIsFull = self.musicPlayer.currentItem?.isPlaybackBufferFull else {return}
					print("F: \(playbackIsFull)")
					
					guard let playbackIsEmpty = self.musicPlayer.currentItem?.isPlaybackBufferEmpty else {return}
					print("E: \(playbackIsEmpty)")
					
					if playbackIsFull {
					// something here to Load next item
					//bufferNextItem()
					print("Buffer Next")
					}
					*/
				}else{
					if !self.staticPlayer.isPlaying{
						//print("Playing Static")
						self.staticPlayer.play()
					}
					
					if self.musicPlayer.currentItem?.status == AVPlayerItem.Status.failed{
						print("Error")
						//print(self.musicPlayer.currentItem?.error?.localizedDescription)
						self.playNextItem()
					}
					
					if self.musicPlayer.status == AVPlayer.Status.failed{
						print("Error")
						//print(self.musicPlayer.error?.localizedDescription)
						self.playNextItem()
					}
					/*
					guard let playbackIsEmpty = self.musicPlayer.currentItem?.isPlaybackBufferEmpty else {return}
					print("E: \(playbackIsEmpty)")
					//print("Not Ready yet")
					*/
				}
				
			})
			
			guard let itemURL = musicPlayer.currentItem?.asset as? AVURLAsset else{return}
			
			currentTrack = itemURL.url.lastPathComponent
			currentTrack.removeLast(4)
			
			// Set Player to Play while buffering - streaming mode
			musicPlayer.rate = 1
			musicPlayer.automaticallyWaitsToMinimizeStalling = false
			
			NotificationCenter.default.addObserver(self,
												   selector: #selector(playerItemDidReachEnd),
												   name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
												   object: nil) // Add observer
			
			musicPlayer.play()
			updateMediaRemoteState()
			isAudioPlayerPlaying = true
		}
		
	}
	
	// MARK: - Permission
	func requestAuth() {
		
		// Request Permission to play in background
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
	
	func initialiseMediaRemote() {
		let remote = MPRemoteCommandCenter.shared()
		
		remote.togglePlayPauseCommand.addTarget { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
			if self.isAudioPlayerPlaying{
				self.isAudioPlayerPlaying = false
				self.musicPlayer.pause()
			}else{
				self.isAudioPlayerPlaying = true
				self.musicPlayer.play()
			}
			
			self.updateMediaRemoteState()
			return MPRemoteCommandHandlerStatus.success
		}
		
		remote.playCommand.addTarget { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
			self.isAudioPlayerPlaying = true
			self.musicPlayer.play()
			
			
			self.updateMediaRemoteState()
			return MPRemoteCommandHandlerStatus.success
		}
		
		remote.pauseCommand.addTarget { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
			self.isAudioPlayerPlaying = false
			self.musicPlayer.pause()
			self.updateMediaRemoteState()
			return MPRemoteCommandHandlerStatus.success
		}
		
		remote.nextTrackCommand.addTarget { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
			//self.playNextItem()
			
			
			if let curItem  = self.musicPlayer.currentItem{
				
				
				self.musicPlayer.pause()
				
				if !self.staticPlayer.isPlaying{
					self.staticPlayer.play()
				}
				
				curItem.seek(to: curItem.duration, completionHandler: { (bol) in
					self.musicPlayer.play()
					if !self.staticPlayer.isPlaying{
						self.staticPlayer.play()
					}
				})
				return MPRemoteCommandHandlerStatus.success
			}else{
				return MPRemoteCommandHandlerStatus.noSuchContent
			}
		}
	}
	
	func updateMediaRemoteState() {
		//let metadata = JSRLSongMetadata(currentTrack!)
		var data:[String] = currentTrack.components(separatedBy: " - ")
		if data.count == 1{
			data.append("Professor K")
		}
		
		let artwork = MPMediaItemArtwork(boundsSize: CGSize(), requestHandler: {size in self.logo})
		
		MPNowPlayingInfoCenter.default().nowPlayingInfo = [
			MPMediaItemPropertyTitle: data[0],
			MPMediaItemPropertyArtist: data[1],
			MPMediaItemPropertyArtwork: artwork,
			MPNowPlayingInfoPropertyPlaybackRate: (isAudioPlayerPlaying ? 1 : 0),
			MPNowPlayingInfoPropertyIsLiveStream: true
		]

	}
	
	/*
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
	
	if keyPath == "currentItem",
	let player = object as? AVPlayer,
	let currentItem = player.currentItem?.asset as? AVURLAsset {
	
	currentTrack = currentItem.url.lastPathComponent
	currentTrack.removeLast(4)
	}
	}
	*/
	
	// Notification Handling
	@objc func playerItemDidReachEnd(notification: NSNotification) {
		//player.seek(to: CMTime.zero)
		//player.play()
		if !self.staticPlayer.isPlaying{
			self.staticPlayer.play()
		}
		musicPlayer.pause()
		musicPlayer.cancelPendingPrerolls()
		musicPlayer.currentItem?.cancelPendingSeeks()

		playNextItem()
	}
	// Remove Observer
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	// MARK: - Play List Maker
	private func playListMaker(stationSelected:[String]) -> [AVPlayerItem]{
		// Load Playlist from the selected Stations
		var playList:[AVPlayerItem] = []
		
		stationSelected.forEach { (station) in
			//stationPlayListRetriever(stationSelected: stationSelected)
			stationPlayListRetriever(stationSelected: station).forEach({ (playListItem) in
				playList.append(playListItem)
			})
		}
		
		playList.shuffle()
		
		// Load radio bumps
		var bumpSet = stationPlayListRetriever(stationSelected: bump)
		//bumpSet.shuffle()
		
		
		// fill the playlist with bumps inbetween
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
	
	// Translate from station to path
	func getStationPath(station:String) -> String {
		
		if station == bump{
			return bumpPath
		}
			
		else if station == classic{
			logo = UIImage(named: "Classic")!
			return classicPath
		}else if station == future{
			logo = UIImage(named: "Future")!
			return futurePath
		}else if station == summer{
			logo = UIImage(named: "Summer")!
			return summerPath
		}else if station == christmas{
			logo = UIImage(named: "Christmas")!
			return christmasPath
		}
			
			
		else if station == ggs{
			logo = UIImage(named: "GG's")!
			return ggsPath
		}else if station == poisonJam{
			logo = UIImage(named: "PoisonJam")!
			return poisonJamPath
		}else if station == noiseTanks{
			logo = UIImage(named: "NoiseTanks")!
			return noiseTanksPath
		}else if station == loveShockers{
			logo = UIImage(named: "LoveShockers")!
			return loveShockersPath
		}
			
		else if station == rapid99{
			logo = UIImage(named: "Rapid99")!
			return rapid99Path
		}else if station == theImmortals{
			logo = UIImage(named: "TheImmortals")!
			return theImmortals
		}else if station == doomRiders{
			logo = UIImage(named: "DoomRiders")!
			return doomRidersPath
		}else if station == goldenRhinos{
			logo = UIImage(named: "GoldenRhinos")!
			return goldenRhinosPath
		}
		
		logo = UIImage(named: "PreloadImage")!
		return ""
	}
	
	
	private func stationPlayListRetriever(stationSelected:String) -> [AVPlayerItem]{
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

/*
extension MusicPlayerObject: AVQueuedSampleBufferRendering{
var timebase: CMTimebase {
<#code#>
}

func enqueue(_ sampleBuffer: CMSampleBuffer) {
<#code#>
}

func flush() {
<#code#>
}

var isReadyForMoreMediaData: Bool {
<#code#>
}

func requestMediaDataWhenReady(on queue: DispatchQueue, using block: @escaping () -> Void) {
<#code#>
}

func stopRequestingMediaData() {
<#code#>
}


}
*/
