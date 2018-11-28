//
//  StationListVC.swift
//  JSRL IOS
//
//  Created by Antonius George on 29/10/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

class StationListVC: UIViewController {

	// MARK: - Object
	let musicPlayer = MusicPlayerObject.shared
	let stationListTimer = RepeatingTimer(timeInterval: TimeInterval.init(exactly: 0.1)!)

	// MARK: - Outlet
	@IBOutlet weak var stationList: UITableView!
	@IBOutlet weak var miniPlayer: UIView!
	
	@IBOutlet weak var skipNextOutlet: UIButton!
	@IBOutlet weak var trackProgressBar: UIProgressView!
	@IBOutlet weak var songNameScrollText: ScrollText!
	
	@IBOutlet weak var bottomList: NSLayoutConstraint!
	@IBOutlet weak var miniPlayerBottom: NSLayoutConstraint!
	@IBOutlet weak var bottomCover: UIView!
	
	// MARK: - Variable
	var toMusicPlayer = true
	var isPlayingSomething = false
	let musicStationList = StationListCreator().StationList()
	
	var trackName = ""
	var trackStation = ""
	var trackLogo:UIImage = UIImage.init(named: "Preloadlogo")!
	var bgColor = UIColor.black
	var acColor = UIColor.black
	var opColor = UIColor.white
	
	var playingAt:IndexPath?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		stationList.delegate = self
		stationList.dataSource = self
		
		miniPlayerBottom.constant = -100
		
		let open = UITapGestureRecognizer(target: self, action: #selector(openPlayer))
		
		songNameScrollText.addGestureRecognizer(open)
		
		//musicPlayer.initializeMusicChecker()
		stationListTimer.eventHandler = {
			self.musicChecker()
		}
		
		stationListTimer.resume()
		
		let controlTap = UITapGestureRecognizer(target: self, action: #selector(controlOnTap))
		let controlHold = UILongPressGestureRecognizer(target: self, action: #selector(controlOnHold))
		controlHold.allowableMovement = 50
		controlHold.minimumPressDuration = 1
		
		skipNextOutlet.addGestureRecognizer(controlTap)
		skipNextOutlet.addGestureRecognizer(controlHold)
		
		
		
		//stationList.rowHeight = 58
		//stationList.backgroundColor = .black
		
		
        // Do any additional setup after loading the view.
    }
	
	func controlsUpdater() {
		if bgColor != .black{
			if musicPlayer.userCommandAudioPlaying{
				skipNextOutlet.setImage(UIImage.init(named: "DarkSkipNext"), for: .normal)
			}else{
				skipNextOutlet.setImage(UIImage.init(named: "DarkPause"), for: .normal)
			}
		}else{
			if musicPlayer.userCommandAudioPlaying{
				skipNextOutlet.setImage(UIImage.init(named: "SkipNext"), for: .normal)
			}else{
				skipNextOutlet.setImage(UIImage.init(named: "Pause"), for: .normal)
			}
		}
	}
	
	
	@objc func controlOnTap(){
		if musicPlayer.userCommandAudioPlaying{
			musicPlayer.playNextItem()
			/*
			if let curItem = musicPlayer.musicPlayer.currentItem, musicPlayer.progress > 0{
				musicPlayer.musicPlayer.pause()
				
				
				curItem.seek(to: curItem.duration) { (bol) in
					self.musicPlayer.musicPlayer.play()
					self.musicPlayer.userCommandAudioPlaying = true
				}
			}
			*/
		}else if musicPlayer.playerItems.isEmpty{
			
		}else{
			
			musicPlayer.musicPlayer.play()
			musicPlayer.userCommandAudioPlaying = true
		}
		controlsUpdater()
	}
	@objc func controlOnHold(){
		if musicPlayer.userCommandAudioPlaying{
			musicPlayer.musicPlayer.pause()
			musicPlayer.userCommandAudioPlaying = false
		}
		controlsUpdater()
	}
	
	func initMiniPlayer(trackName:String, bgColor:UIColor,acColor:UIColor){
		songNameScrollText.destroy()
		var tnColor = UIColor.purple
		if bgColor != .black{
			tnColor = UIColor.black
		}else{
			tnColor = UIColor.white
		}
		
		//trackProgressBar.progress = 0.0
		trackProgressBar.tintColor = acColor
		
		skipNextOutlet.tintColor = tnColor
		skipNextOutlet.awakeFromNib()
		
		
		songNameScrollText.setup(text: trackName, BackgroundColor: bgColor, TextColor: tnColor)
		
		bottomCover.backgroundColor = bgColor
		
	}
	
	func musicChecker(){
		DispatchQueue.main.async {
			if self.trackName != self.musicPlayer.currentTrack{
				self.trackName = self.musicPlayer.currentTrack
				self.initMiniPlayer(trackName: self.trackName, bgColor: self.bgColor, acColor: self.acColor)
			}
			
			//self.trackProgressBar.progress = self.musicPlayer.progress
			self.trackProgressBar.setProgress(self.musicPlayer.progress, animated: true)
		}
		
	}
	
	@objc func openPlayer(){
		performSegue(withIdentifier: "toPlayer", sender: self)
	}

	
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if toMusicPlayer {
			let playerVC = segue.destination as! PlayerVC
			
			playerVC.acColor = acColor
			playerVC.bgcolor = bgColor
			
			playerVC.track = trackName
			playerVC.station = trackStation
			playerVC.logo = trackLogo
		}
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		songNameScrollText.destroy()
		stationListTimer.suspend()
	}

	override func viewDidAppear(_ animated: Bool) {
		controlsUpdater()
		UIApplication.shared.beginReceivingRemoteControlEvents()
		initMiniPlayer(trackName: trackName, bgColor: bgColor, acColor: acColor)
		stationList.reloadData()
		stationListTimer.resume()
		controlsUpdater()
	}
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // change 2 to desired number of seconds
			self.initMiniPlayer(trackName: self.trackName, bgColor: self.bgColor, acColor: self.acColor)
			self.viewLayoutMarginsDidChange()
			
		}
	}
	
	override func prefersHomeIndicatorAutoHidden() -> Bool {
		return true
	}
	
}

extension StationListVC: UITableViewDelegate, UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 40
	}

	
	func numberOfSections(in tableView: UITableView) -> Int {
		return musicStationList.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return musicStationList[section].musicStation.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if miniPlayerBottom.constant != 0{
			miniPlayerBottom.constant = 0
			bottomList.isActive = false
			UIView.animate(withDuration: 0.3) {
				self.view.layoutIfNeeded()
			}
		}
		
		if playingAt != indexPath{
		
			trackStation = musicStationList[indexPath.section].musicStation[indexPath.row].name
			bgColor = .black
			acColor = musicStationList[indexPath.section].musicStation[indexPath.row].acLogoColor
			playingAt = indexPath
			
			//if musicStationList[indexPath.section].group == "Seasonal"{
			//	bgColor = musicStationList[indexPath.section].musicStation[indexPath.row].bgLogoColor
			//}
			
			self.miniPlayer.backgroundColor = self.bgColor
			self.skipNextOutlet.backgroundColor = self.bgColor
			self.bottomCover.backgroundColor = self.bgColor
			

			trackLogo = musicStationList[indexPath.section].musicStation[indexPath.row].logo
			
			DispatchQueue.main.async {
				self.musicPlayer.playMusic(station: [self.trackStation])
				self.controlsUpdater()
			}
			
			
			stationList.reloadData()
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		return musicStationList[section].group
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MusicStationCell
		
		cell.stationImage.image = musicStationList[indexPath.section].musicStation[indexPath.row].logo
		cell.stationImage.backgroundColor = musicStationList[indexPath.section].musicStation[indexPath.row].bgLogoColor
		
		cell.stationName.text = musicStationList[indexPath.section].musicStation[indexPath.row].name
		cell.stationPlayingIndicator.animating = false
		cell.stationPlayingIndicator.alpha = 0
		
		if let playAt = playingAt{
			if playAt == indexPath{
				cell.stationPlayingIndicator.alpha = 1
				cell.stationPlayingIndicator.animating = true
			}
		}
		
		//musicStationList[indexPath.section].MusicStation[indexPath.row].name
		
		return cell
	}
	
	
}
