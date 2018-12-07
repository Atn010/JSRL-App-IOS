//
//  ViewController.swift
//  JSRL IOS
//
//  Created by Antonius George on 25/08/18.
//  Copyright © 2018 Atn010. All rights reserved.
//

import UIKit
import AVFoundation
import Fabric
import Crashlytics

class PlayerVC: UIViewController {
	
	// MARK: - Object
	let musicPlayer = MusicPlayerObject.shared
	let musicPlayerPageTimer = RepeatingTimer(timeInterval: TimeInterval.init(exactly: 0.1)!)
	
	
	// MARK: - Outlet
	@IBOutlet weak var stationLogo: UIImageView!
	@IBOutlet weak var scrollingTrackName: ScrollText!
	@IBOutlet weak var trackProgressBar: UIProgressView!
	@IBOutlet weak var playPauseButton: UIButton!
	@IBOutlet weak var skipNextButton: UIButton!
	@IBOutlet weak var deadButton: UIButton!
	
	@IBOutlet weak var playerControlsBG: UIView!
	@IBOutlet weak var playerControlsBGExtra: UIView!
	// MARK: - Variable
	var bgcolor:UIColor = .black
	var acColor:UIColor = .white
	
	var station:String = ""
	var logo:UIImage = UIImage.init(named: "Preloadlogo")!
	var revLogo:UIImage = UIImage.init(named: "Preloadlogo")!
	
	var track:String = ""
	var isTopRight = true
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		stationLogo.image = logo
		//revLogo = logo.withHorizontallyFlippedOrientation()
		//revLogo = logo.image
		self.title = station
		/*
		//if bgcolor == .black{
		//let playerControlBGColor:UIColor = bgcolor.lighter(by: 15) ?? .black
		let playerControlBGColor:UIColor = bgcolor
		playerControlsBG.backgroundColor = playerControlBGColor
		playerControlsBGExtra.backgroundColor = playerControlBGColor
		*/
		//}else{
		let playerControlBGColor = bgcolor//.lighter(by: 5)
		playerControlsBG.backgroundColor = playerControlBGColor
		playerControlsBGExtra.backgroundColor = playerControlBGColor
		//}
		initMusicPlayer(trackName: "", bgColor: bgcolor, acColor: acColor)
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(returnToList))
		
		musicPlayerPageTimer.eventHandler = {
			self.musicChecker()
		}
		
		musicPlayerPageTimer.resume()
		
		controlsUpdater()
		trackProgressBar.progress = musicPlayer.progress
		initDeadButton()
		//DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // change 2 to desired number of seconds
			self.initDeadButton()
		//}
		// Do any additional setup after loading the view, typically from a nib.
		//animateLogo()
	}
	
	func musicChecker(){
		DispatchQueue.main.async {
			if self.track != self.musicPlayer.currentTrack{
				self.track = self.musicPlayer.currentTrack
				self.initMusicPlayer(trackName: self.track, bgColor: self.bgcolor, acColor: self.acColor)
			}
			
			self.trackProgressBar.setProgress(self.musicPlayer.progress, animated: true)
		}
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		musicPlayerPageTimer.suspend()
		scrollingTrackName.destroy()
		controlsUpdater()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		initMusicPlayer(trackName: track, bgColor: bgcolor, acColor: acColor)
		musicPlayerPageTimer.resume()
		controlsUpdater()
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // change 2 to desired number of seconds
			self.initDeadButton()
		}
	}
	override var preferredStatusBarStyle: UIStatusBarStyle {
		/*
		if bgcolor != .black{
		return .default
		}else{
		*/
		return .lightContent
		//}
	}
	override func prefersHomeIndicatorAutoHidden() -> Bool {
		return true
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // change 2 to desired number of seconds
			self.initMusicPlayer(trackName: self.track, bgColor: self.bgcolor, acColor: self.acColor)
			self.viewLayoutMarginsDidChange()
			
		}
		
		initDeadButton()
	}
	
	func animateLogo(){
		
		if isTopRight{
			isTopRight = false
			stationLogo.image = logo
			UIView.transition(with: stationLogo, duration: 5, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: {
				
			}) { (bol) in
				self.animateLogo()
			}
		}else{
			isTopRight = true
			stationLogo.image = revLogo
			UIView.transition(with: stationLogo, duration: 5, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: {
				
			}) { (bol) in
				self.animateLogo()
			}
		}
		
	}
	
	private func initDeadButton() {
		if UIDevice.current.orientation.isLandscape {
			
			switch self.sizeClass() {
			case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
				deadButton.backgroundColor = .clear
				deadButton.setImage(nil, for: .normal)
			default:
				deadButton.backgroundColor = bgcolor
				deadButton.setImage(stationLogo.image!, for: .normal)
			}
			
		} else {
			deadButton.backgroundColor = .clear
			deadButton.setImage(nil, for: .normal)
		}
	}
	
	func controlsUpdater() {
		/*
		if bgcolor != .black{
		self.navigationController?.navigationBar.barStyle = .default
		if musicPlayer.userCommandAudioPlaying{
		playPauseButton.setImage(UIImage.init(named: "LDarkPause"), for: .normal)
		}else{
		playPauseButton.setImage(UIImage.init(named: "DarkPlay"), for: .normal)
		}
		
		skipNextButton.setImage(UIImage.init(named: "DarkSkipNext"), for: .normal)
		*/
		//}else{
		self.navigationController?.navigationBar.barStyle = .black
		if musicPlayer.userCommandAudioPlaying{
			playPauseButton.setImage(UIImage.init(named: "LPause"), for: .normal)
		}else{
			playPauseButton.setImage(UIImage.init(named: "Play"), for: .normal)
		}
		skipNextButton.setImage(UIImage.init(named: "SkipNext"), for: .normal)
		//}
		
	}
	
	
	func initMusicPlayer(trackName:String, bgColor:UIColor,acColor:UIColor){
		scrollingTrackName.destroy()
		var tnColor = UIColor.purple
		/*
		if bgColor != .black{
		tnColor = UIColor.black
		self.view.backgroundColor = bgColor
		//deadButton.backgroundColor = bgColor
		}else{
		*/
		tnColor = UIColor.white
		self.view.backgroundColor = .black
		
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
		self.navigationController?.navigationBar.barTintColor = .black
		self.navigationController?.navigationBar.tintColor = .white
		//self.deadButton.backgroundColor = bgColor
		//}
		//trackProgressBar.progress = 0.0
		trackProgressBar.tintColor = acColor
		
		scrollingTrackName.setup(text: trackName, TextColor: tnColor)
		
	}
	@objc func returnToList(){
		scrollingTrackName.destroy()
		self.navigationController?.navigationBar.barStyle = .default
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
		self.navigationController?.navigationBar.barTintColor = .white
		self.navigationController?.navigationBar.tintColor = .black
		self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func playPauseClicked(_ sender: UIButton) {
		if musicPlayer.userCommandAudioPlaying{
			musicPlayer.musicPlayer.pause()
			musicPlayer.userCommandAudioPlaying = false
		}else if musicPlayer.playerItems.isEmpty{
			musicPlayer.userCommandAudioPlaying = false
		}else{
			musicPlayer.musicPlayer.play()
			musicPlayer.userCommandAudioPlaying = true
		}
		controlsUpdater()
		
		
	}
	@IBAction func skipNextClicked(_ sender: UIButton) {
		musicPlayer.playNextItem()
		scrollingTrackName.destroy()
		/*
		if let curItem = musicPlayer.musicPlayer.currentItem, musicPlayer.progress > 0{
		musicPlayer.musicPlayer.pause()
		
		curItem.seek(to: curItem.duration) { (bol) in
		self.musicPlayer.musicPlayer.play()
		self.musicPlayer.userCommandAudioPlaying = true
		}
		}
		*/
		
	}
	
	
	
}

extension UIViewController {
	func sizeClass() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
		return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
	}
}

