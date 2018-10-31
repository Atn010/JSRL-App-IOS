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
	
	static let shared = AudioPlayerObject()
	
	override private init() {
		
		do {
			//keep alive audio at background
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
		} catch _ {
			print("Failed set category")
		}
		do {
			try AVAudioSession.sharedInstance().setActive(true)
		} catch _ {
			print("Failed set Active")
		}
		UIApplication.shared.beginReceivingRemoteControlEvents()
		audioURL = URL(fileURLWithPath: "")
		audioPlayer = AVAudioPlayer()
		
	}
	
	var audioURL:URL
	
	
	var audioPlayer:AVAudioPlayer

}


