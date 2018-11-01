//
//  AudioPlayerObject.swift
//  JSRL IOS
//
//  Created by Antonius George on 03/09/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayerObject: NSObject {
	
	var currentTrack = ""
	var progress:CGFloat = 0.0
	
	static let shared = AudioPlayerObject()
	lazy var player: AVQueuePlayer = self.makePlayer()
	
	private lazy var songs: [AVPlayerItem] = {
		let songNames = ["bump1", "bump2", "bump3", "bump4", "bump5"]
		return songNames.map {
			let url = Bundle.main.url(forResource: $0, withExtension: "mp3")!
			return AVPlayerItem(url: url)
		}
	}()
	
	override private init() {
		do {/*
			try AVAudioSession.sharedInstance().setCategory( AVAudioSession.Category.playAndRecord,mode: .default,options: [])
			*/
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
/*
			try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
			try AVAudioSession.sharedInstance().setActive(true)
*/
		} catch {
			print("Failed to set audio session category.  Error: \(error)")
		}
		/*
		player.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 100), queue: DispatchQueue.main) { [weak self] time in
			guard let self = self else { return }
			let timeString = String(format: "%02.2f", CMTimeGetSeconds(time))
			
			if UIApplication.shared.applicationState == .active {
				//self.timeLabel.text = timeString
			} else {
				print("Background: \(timeString)")
			}
		}
*/

	}
	
	private func makePlayer() -> AVQueuePlayer {
		let player = AVQueuePlayer(items: songs)
		player.actionAtItemEnd = .advance
		player.addObserver(self, forKeyPath: "currentItem", options: [.new, .initial] , context: nil)
		return player
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "currentItem",
			let player = object as? AVPlayer,
			let currentItem = player.currentItem?.asset as? AVURLAsset {
			currentTrack = currentItem.url.lastPathComponent
		}
	}
	

	

}


