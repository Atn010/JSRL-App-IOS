//
//  ViewController.swift
//  JSRL IOS
//
//  Created by Antonius George on 25/08/18.
//  Copyright © 2018 Atn010. All rights reserved.
//

import UIKit
import AVFoundation
class PlayerVC: UIViewController {
	
	// MARK: - Object
	let musicPlayer = MusicPlayerObject.shared
	let musicPlayerPageTimer = RepeatingTimer(timeInterval: TimeInterval.init(exactly: 0.2)!)
	
	
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
	
	var track: String = "Loading..."
	
	override func viewDidLoad() {
		super.viewDidLoad()
		registerNotificationObserver()
		
		
		self.navigationController?.navigationBar.barStyle = .black
		self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
		self.addRightBarButtonItem(image: UIImage.init(named: "station")?.withRenderingMode(.alwaysTemplate), tintColor: .white, selector: #selector(openList))
		self.addRightBarButtonItem(image: UIImage.init(named: "history")?.withRenderingMode(.alwaysTemplate), tintColor: .white, selector: #selector(openHistory))
		
		self.title = musicPlayer.currentStation.rawValue
		playerControlsBG.backgroundColor = UIColor.init(hexString: "#111111")
		playerControlsBGExtra.backgroundColor = UIColor.init(hexString: "#111111")
		initMusicPlayer(trackName: "")
		
		musicPlayerPageTimer.eventHandler = {
			self.musicChecker()
		}
		
		musicPlayerPageTimer.resume()
		
		controlsUpdater()
		trackProgressBar.progress = musicPlayer.progress
		initDeadButton()
		
		if let stationString = UserDefaults.standard.object(forKey: "LastPlayed") as? String {
			let station = StationListInfo.getStationName(from: stationString)
			if station == .shuffle {
				self.musicPlayer.playMusic(station: StationListInfo.shuffleList)
			} else {
				self.musicPlayer.playMusic(station: [station])
			}
		}
		
		self.initMusicPlayer(trackName: "")
		playPauseButton.tintColor = UIColor.init(hexString: "#FFFFFF")
		skipNextButton.tintColor = UIColor.init(hexString: "#4B4B4D")
	}
	
	func musicChecker(){
		DispatchQueue.main.async {
			if self.track != self.musicPlayer.currentTrack{
				self.track = self.musicPlayer.currentTrack
				self.initMusicPlayer(trackName: self.track)
			}
			
			self.trackProgressBar.setProgress(self.musicPlayer.progress, animated: true)
			self.controlsUpdater()
		}
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		musicPlayerPageTimer.resume()
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { 
			self.initDeadButton()
		}
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	override var prefersHomeIndicatorAutoHidden: Bool {
		return true
	}
	
	private func initDeadButton() {
		if UIDevice.current.orientation.isLandscape {
			
			switch self.sizeClass() {
			case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
				deadButton.backgroundColor = .clear
				deadButton.setImage(nil, for: .normal)
			default:
				deadButton.setImage(stationLogo.image!, for: .normal)
			}
			
		} else {
			deadButton.backgroundColor = .clear
			deadButton.setImage(nil, for: .normal)
		}
	}
	
	func controlsUpdater() {
		if musicPlayer.userCommandAudioPlaying{
			playPauseButton.setImage(UIImage.init(named: "LPause")?.withRenderingMode(.alwaysTemplate), for: .normal)
		} else {
			playPauseButton.setImage(UIImage.init(named: "Play")?.withRenderingMode(.alwaysTemplate), for: .normal)
		}
		skipNextButton.setImage(UIImage.init(named: "SkipNext")?.withRenderingMode(.alwaysTemplate), for: .normal)
		
		
	}
	
	
	func initMusicPlayer(trackName: String) {
		scrollingTrackName.destroy()
		self.view.backgroundColor = .black
		self.title = musicPlayer.currentStation.rawValue
		self.stationLogo.image = StationListInfo.getStationImage(station: musicPlayer.currentStation)
		
		let accent = StationListInfo.getStationAccent(station: musicPlayer.currentStation)
		trackProgressBar.tintColor = accent
		trackProgressBar.backgroundColor = accent.darker()
		
		scrollingTrackName.setup(text: trackName, TextColor: UIColor.white)
		
	}
	@objc func openList(){
		let vc = StationListViewController.init()
		vc.modalTransitionStyle = .coverVertical
		self.present(UINavigationController.init(rootViewController: vc), animated: true, completion: nil)
		
	}
	
	@objc func openHistory(){
		let vc = MusicHistoryVC.init()
		vc.modalTransitionStyle = .coverVertical
		self.present(UINavigationController.init(rootViewController: vc), animated: true, completion: nil)
		
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
	}
}

extension PlayerVC {
	func registerNotificationObserver() {
		NotificationCenter.default.addObserver(forName: .init("First Run Update"), object: nil, queue: .main) { [weak self] notification in
			guard let self = self else { return }
			self.musicPlayer.playMusic(station: [.classic])
		}
	}
}

extension UIViewController {
	func sizeClass() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
		return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
	}
}

