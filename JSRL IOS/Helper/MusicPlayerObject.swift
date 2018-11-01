//
//  MusicPlayerObject.swift
//  JSRL IOS
//
//  Created by Antonius George on 01/11/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerObject: NSObject{
	
	var currentTrack = ""
	var progress:Float = 0.0
	var isAudioPlayerPlaying = false
	
	
	static let shared = MusicPlayerObject()
	let t = RepeatingTimer(timeInterval: TimeInterval.init(exactly: 0.1)!)
	var audioPlayer =  AVQueuePlayer()
	var staticPlayer = AVAudioPlayer()
	
	override private init() {
		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
			
			try staticPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "static", ofType: "mp3")!))
			staticPlayer.numberOfLoops = -1
			
		} catch {
			print("Failed to set audio session category.  Error: \(error)")
		}
	}
	
	func initializeMusicChecker(){
		t.eventHandler = {
			self.musicProgressChecker()
		}
		
		t.resume()
	}
	func musicProgressChecker(){
		if currentTrack != ""{
			guard let currentTime = audioPlayer.currentItem?.currentTime() else{return}
			guard let totalTime = audioPlayer.currentItem?.duration else{return}
			
			let current = CMTimeGetSeconds(currentTime)
			let total = CMTimeGetSeconds(totalTime)
			
			progress = Float(current / total)
			if audioPlayer.items().count == 1{
				if progress >= 0.99{
					progress = 0
					currentTrack = ""
					audioPlayer.removeAllItems()
				}
			}
		}
		
		//print("Audioplayer: \(audioPlayer.items().count) - \(audioPlayer.items().isEmpty)")
		if audioPlayer.items().count == 0{
			if staticPlayer.isPlaying == false{
				staticPlayer.play()
			}
		}else{
			if staticPlayer.isPlaying == true{
				staticPlayer.stop()
			}
		}
		
	}
	
	func playMusic(station:String){
		audioPlayer = AVQueuePlayer.init(items: playListMaker(stationSelected: station))
		audioPlayer.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial] , context: nil)
		audioPlayer.play()
		isAudioPlayerPlaying = true
		
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
		
		return playList
	}
	
	private func stationPlayListRetriever(stationSelected:String) -> [AVPlayerItem]{
		var stationPlayList: [AVPlayerItem] = []
		stationPlayList.append(AVPlayerItem.init(url: URL(fileURLWithPath: Bundle.main.path(forResource: "bump1", ofType: "mp3")!)))
		stationPlayList.append(AVPlayerItem.init(url: URL(fileURLWithPath: Bundle.main.path(forResource: "bump2", ofType: "mp3")!)))
		//stationPlayList.append(AVPlayerItem.init(url: URL(fileURLWithPath: Bundle.main.path(forResource: "bump3", ofType: "mp3")!)))
		//stationPlayList.append(AVPlayerItem.init(url: URL(fileURLWithPath: Bundle.main.path(forResource: "bump4", ofType: "mp3")!)))
		//stationPlayList.append(AVPlayerItem.init(url: URL(fileURLWithPath: Bundle.main.path(forResource: "bump5", ofType: "mp3")!)))
		return stationPlayList
	}
	
	
}
