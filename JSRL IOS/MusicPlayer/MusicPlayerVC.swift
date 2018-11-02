//
//  ViewController.swift
//  JSRL IOS
//
//  Created by Antonius George on 25/08/18.
//  Copyright © 2018 Atn010. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerVC: UIViewController {
	
	// MARK: - Object
	let musicPlayer = MusicPlayerObject.shared
	let t = RepeatingTimer(timeInterval: TimeInterval.init(exactly: 0.1)!)
	
	
	// MARK: - Outlet
	@IBOutlet weak var stationLogo: UIImageView!
	@IBOutlet weak var scrollingTrackName: ScrollText!
	@IBOutlet weak var trackProgressBar: UIProgressView!
	@IBOutlet weak var playPauseButton: UIButton!
	@IBOutlet weak var skipNextButton: UIButton!
	@IBOutlet weak var deadButton: UIButton!
	
	// MARK: - Variable
	var bgcolor:UIColor = .black
	var acColor:UIColor = .white
	
	var station:String = ""
	var logo:UIImage = UIImage.init(named: "Preloadlogo")!
	
	var track:String = ""
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		stationLogo.image = logo
		self.title = station
		initMusicPlayer(trackName: track, bgColor: bgcolor, acColor: acColor)
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(returnToList))
		musicPlayer.initializeMusicChecker()
		t.eventHandler = {
			self.musicChecker()
		}
		
		t.resume()
		
		controlsUpdater()
		//testPlayButton.isEnabled = true
		//testPlayButton.setTitle("Loading List", for: .normal)
		//loadingStatus = true
		
		//clearTempFolder()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	func musicChecker(){
		DispatchQueue.main.async {
			if self.track != self.musicPlayer.currentTrack{
				self.track = self.musicPlayer.currentTrack
				self.initMusicPlayer(trackName: self.track, bgColor: self.bgcolor, acColor: self.acColor)
			}
			
			self.trackProgressBar.progress = self.musicPlayer.progress
		}
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		t.suspend()
		controlsUpdater()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		initMusicPlayer(trackName: track, bgColor: bgcolor, acColor: acColor)
		t.resume()
		controlsUpdater()
	}
	
	func controlsUpdater() {
		if bgcolor != .black{
			if musicPlayer.isAudioPlayerPlaying{
				playPauseButton.setImage(UIImage.init(named: "DarkCirclePause"), for: .normal)
			}else{
				playPauseButton.setImage(UIImage.init(named: "DarkCirclePlay"), for: .normal)
			}
			
			skipNextButton.setImage(UIImage.init(named: "DarkSkipNext"), for: .normal)
		}else{
			if musicPlayer.isAudioPlayerPlaying{
				playPauseButton.setImage(UIImage.init(named: "CirclePause"), for: .normal)
			}else{
				playPauseButton.setImage(UIImage.init(named: "CirclePlay"), for: .normal)
			}
			skipNextButton.setImage(UIImage.init(named: "SkipNext"), for: .normal)
		}
	}

	
	func initMusicPlayer(trackName:String, bgColor:UIColor,acColor:UIColor){
		scrollingTrackName.destroy()
		
		var tnColor = UIColor.purple
		if bgColor != .black{
			tnColor = UIColor.black
			self.view.backgroundColor = bgColor
			deadButton.backgroundColor = bgColor
		}else{
			tnColor = UIColor.white
			self.view.backgroundColor = .black
			
			self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
			self.navigationController?.navigationBar.barTintColor = .black
			self.navigationController?.navigationBar.tintColor = .white
		}
		trackProgressBar.progress = 0.7
		trackProgressBar.tintColor = acColor
		
		scrollingTrackName.setup(text: trackName, BackgroundColor: bgColor, TextColor: tnColor)
		
	}
	@objc func returnToList(){
		scrollingTrackName.destroy()
		
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
		self.navigationController?.navigationBar.barTintColor = .white
		self.navigationController?.navigationBar.tintColor = .black
		self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func playPauseClicked(_ sender: UIButton) {
		if musicPlayer.isAudioPlayerPlaying{
			musicPlayer.musicPlayer.pause()
			musicPlayer.isAudioPlayerPlaying = false
		}else if musicPlayer.playerItems.isEmpty{
			musicPlayer.isAudioPlayerPlaying = false
		}else{
			musicPlayer.musicPlayer.play()
			musicPlayer.isAudioPlayerPlaying = true
		}
		controlsUpdater()
		
		
	}
	@IBAction func skipNextClicked(_ sender: UIButton) {
		musicPlayer.playNextItem()
	}
	
	
	
}

