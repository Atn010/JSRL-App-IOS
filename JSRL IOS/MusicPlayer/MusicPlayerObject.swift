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

import SwiftAudioPlayer

class MusicPlayerObject: NSObject{
	
	var currentTrack = ""
	var progress:Float = 0.0
	var userCommandAudioPlaying = false
	var audioPlayingStatus = false
	var currentStation = StationListInfo.Name.classic
	
	
	static let shared = MusicPlayerObject()
	let MusicPlayerObjectTimer = RepeatingTimer(timeInterval: TimeInterval.init(exactly: 0.5)!)
	var staticPlayer = AVAudioPlayer()
	var playerItems: [AVPlayerItem] = []
	var musicPlayer = AVPlayer()
	private var index = 0
	
	private var logo:UIImage = UIImage.init(named: "Preloadlogo")!
	
	private var loadingNextItem = false
	private var nextItem:AVPlayerItem?
	private var nextItemisLoaded = false
	
	private var forcePlay = 0
	private var observer:Any?
	
	// MARK: - Init
	// Register Audio Session
	// Initialize Static Player
	override private init() {
		do {
			UIApplication.shared.beginReceivingRemoteControlEvents()
			try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
			
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
		MusicPlayerObjectTimer.eventHandler = {
			self.musicProgressChecker()
		}
		
		MusicPlayerObjectTimer.resume()
	}
	
	// Background music checker on another thread
	func musicProgressChecker(){
		if currentTrack != "" || currentTrack != "Loading"{
			
			// Checks the progress of music in background, and update to this object
			guard let currentTime = musicPlayer.currentItem?.currentTime() else{return}
			guard let totalTime = musicPlayer.currentItem?.duration else{return}
			
			let current = CMTimeGetSeconds(currentTime)
			let total = CMTimeGetSeconds(totalTime)
			
			progress = Float(current / total)
			
			
			if self.musicPlayer.timeControlStatus == AVPlayer.TimeControlStatus.paused{
				self.audioPlayingStatus = false
			}else{
				self.audioPlayingStatus = true
			}
			
			if let curItem  = self.musicPlayer.currentItem, curItem.error == nil{
				
				if audioPlayingStatus == false && userCommandAudioPlaying == true && forcePlay >= 5{
					print("I FORCE YOU TO PLAY")
					musicPlayer.play()
					forcePlay = 0
				}
				
				if audioPlayingStatus == false && userCommandAudioPlaying == true{
					forcePlay += 1
				}
			}
			//print("\(self.index)/\(self.playerItems.count) ~ \(Date()) ~ Playing: \(self.userCommandAudioPlaying)/\(self.audioPlayingStatus) ~ Force Play Count \(forcePlay)")
			
			// Checks if Meida
			
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
		musicPlayer.pause()
		
		if let currentItem = musicPlayer.currentItem,
		   currentItem.accessibilityLabel != "bump" {
			DispatchQueue.main.async {
				self.updateHistoryList(track: self.currentTrack)
			}
		}
		
		
		// Switch state to Loading
		currentTrack = "Loading"
		if !self.staticPlayer.isPlaying{
			self.staticPlayer.play()
		}
		// Checks if Next item isn't index out of bound
		if index + 1 >= playerItems.count{
			userCommandAudioPlaying = false
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
				musicPlayer.seek(to: CMTime.zero) { (bol) in
					// On Completion:
					self.musicPlayer.pause()
					if !self.staticPlayer.isPlaying{
						//print("Playing Static")
						self.staticPlayer.play()
					}
					
					let nextPlayerItem:AVPlayerItem = self.playerItems[self.index]
					
					// Remove previous item
					//self.playerItems.remove(at: self.index - 1)
					//musicPlayer.seek(to: kCMTimeZero)
					self.musicPlayer.replaceCurrentItem(with: nextPlayerItem)
					self.musicPlayer.currentItem?.canUseNetworkResourcesForLiveStreamingWhilePaused = true
					
					// Show updated Music Track name to User
					guard let itemURL = self.musicPlayer.currentItem?.asset as? AVURLAsset else{return}
					
					self.currentTrack = itemURL.url.lastPathComponent
					self.currentTrack.removeLast(4)
					print("\(self.index)/\(self.playerItems.count) ~ \(Date()) ~ \(self.currentTrack)")
					self.updateMediaRemoteState()
					self.musicPlayer.play()
					self.userCommandAudioPlaying = true
					
					//self.progress = 0
				}
				
				
			}
		}
	}
	
	@objc private func bufferNextItem(){
		// TODO
		print("Buffering Next Here Maybe")
		
	}
	
	// MARK: - Initialize Music Player
	func playMusic(station:[StationListInfo.Name]){
		// Restart Music player
		musicPlayer.pause()
		if !self.staticPlayer.isPlaying{
			self.staticPlayer.play()
		}
		
		if station.count > 1 {
			UserDefaults.standard.setValue(StationListInfo.Name.shuffle.rawValue, forKey: "LastPlayed")
			currentStation = .shuffle
		} else if let stationName = station.first {
			currentStation = stationName
			UserDefaults.standard.setValue(stationName.rawValue, forKey: "LastPlayed")
		}
		 
		playerItems = playListMaker(stationSelected: station)
		index = 0
		
		if playerItems.count > 0 {
			musicPlayer = AVPlayer(playerItem: playerItems[index])
			
			
			NotificationCenter.default.removeObserver(self)
			observer = musicPlayer.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { time in
				
				if self.musicPlayer.currentItem?.status == AVPlayerItem.Status.readyToPlay {
					//print("here I am")
					if self.staticPlayer.isPlaying{
						//print("Stopping Static Player")
						self.musicPlayer.play()
						self.staticPlayer.stop()
					}
				}else{
					//print("don't thread on me")
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
			/*
			NotificationCenter.default.addObserver(self,
												   selector: #selector(bufferNextItem),
												   name: NSNotification.Name.AVPlayer,
												   object: nil) // Add observer
			*/
			musicPlayer.play()
			updateMediaRemoteState()
			userCommandAudioPlaying = true
		}
		
	}
	
	
	private func initialiseMediaRemote() {
		let remote = MPRemoteCommandCenter.shared()
		
		remote.togglePlayPauseCommand.addTarget { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
			if self.userCommandAudioPlaying{
				self.userCommandAudioPlaying = false
				self.musicPlayer.pause()
			}else{
				self.userCommandAudioPlaying = true
				self.musicPlayer.play()
			}
			
			self.updateMediaRemoteState()
			return MPRemoteCommandHandlerStatus.success
		}
		
		remote.playCommand.addTarget { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
			self.userCommandAudioPlaying = true
			self.musicPlayer.play()
			
			
			self.updateMediaRemoteState()
			return MPRemoteCommandHandlerStatus.success
		}
		
		remote.pauseCommand.addTarget { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
			self.userCommandAudioPlaying = false
			self.musicPlayer.pause()
			self.updateMediaRemoteState()
			return MPRemoteCommandHandlerStatus.success
		}
		
		remote.nextTrackCommand.addTarget { (MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
			self.playNextItem()
			return MPRemoteCommandHandlerStatus.success
		}
	}
	
	private func updateMediaRemoteState() {
		//let metadata = JSRLSongMetadata(currentTrack!)
		var data:[String] = currentTrack.components(separatedBy: " - ")
		if data.count == 1{
			data.append("Professor K")
		}
		
		let MPLogo = logo
		
		let artwork = MPMediaItemArtwork(boundsSize: CGSize(), requestHandler: {size in MPLogo})
		
		MPNowPlayingInfoCenter.default().nowPlayingInfo = [
			MPMediaItemPropertyTitle: data[0],
			MPMediaItemPropertyArtist: data[1],
			MPMediaItemPropertyArtwork: artwork,
			MPNowPlayingInfoPropertyPlaybackRate: (userCommandAudioPlaying ? 1 : 0),
			MPNowPlayingInfoPropertyIsLiveStream: true
		]
		
	}
	
	
	// Notification Handling
	@objc func playerItemDidReachEnd(notification: NSNotification) {
		//player.seek(to: CMTime.zero)
		//player.play()
		//		if !self.staticPlayer.isPlaying{
		//			self.staticPlayer.play()
		//		}
		//		//musicPlayer.pause()
		playNextItem()
	}
	
	// Remove Observer
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	// MARK: - Play List Maker
	private func playListMaker(stationSelected:[StationListInfo.Name]) -> [AVPlayerItem]{
		// Load Playlist from the selected Stations
		var playList:[AVPlayerItem] = []
		
		logo = StationListInfo.getStationImage(station: stationSelected.first ?? StationListInfo.Name.shuffle)
		stationSelected.forEach { (station) in
			//stationPlayListRetriever(stationSelected: stationSelected)
			stationPlayListRetriever(stationSelected: station).forEach({ (playListItem) in
				playList.append(playListItem)
			})
		}
		
		playList.shuffle()
		
		// Load radio bumps
		let bumpSet = stationPlayListRetriever(stationSelected: StationListInfo.Name.bump)
		
		
		// fill the playlist with bumps inbetween
		var counting = 0
		var itemCount = 0
		var randomInterval = Int.random(in: 3 ... 5)
		
		let totalBump = bumpSet.count
		
		if totalBump != 0 || playList.count != 0 {
			
			playList.insert(bumpSet[Int.random(in: 0 ... totalBump)], at: 0)
			while itemCount < playList.count {
				counting += 1
				if counting == randomInterval{
					
					playList.insert(bumpSet[Int.random(in: 0 ... totalBump)], at: itemCount)
					counting = 0
					randomInterval = Int.random(in: 3 ... 5)
				}
				
				itemCount+=1
			}
			
		}else{
			UserDefaults.standard.removeObject(forKey: "date")
			ListUpdater.shared.checkForUpdate()
			
			playList.append(AVPlayerItem.init(url: staticPlayer.url!))
		}
		
		
		return playList
	}
	
	
	
	
	private func stationPlayListRetriever(stationSelected: StationListInfo.Name) -> [AVPlayerItem]{
		let station = StationListInfo.getStationPath(station: stationSelected)
		
		var stationPlayList: [AVPlayerItem] = []
		guard station != "",
			  let list = UserDefaults.standard.stringArray(forKey: stationSelected.rawValue)
		else { return stationPlayList  }
		print(stationSelected)
		list.forEach { (item) in
			
			let stringURL = StationListInfo.jetsetradio.rawValue + StationListInfo.stationPath.rawValue + station + item + StationListInfo.fileExtension.rawValue
			if let readyString = stringURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
				if let validURL = URL(string: readyString){
					let playItem = AVPlayerItem.init(url: validURL)
					if stationSelected == .bump { playItem.accessibilityLabel = "bump" }
					stationPlayList.append(playItem)
					return
				}
			}
		}
		
		
		
		return stationPlayList
	}
	
	private func updateHistoryList(track: String){
		var array = UserDefaults.standard.array(forKey: "MusicHistory") as? [String] ?? []
		if array.last ?? "" == track || track == "Loading" { return }
		array.append(track)
		UserDefaults.standard.setValue(array, forKey: "MusicHistory")
		NotificationCenter.default.post(name: .init("Update History"), object: nil)
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
	return input.rawValue
}
