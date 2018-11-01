//
//  ViewController.swift
//  JSRL IOS
//
//  Created by Antonius George on 25/08/18.
//  Copyright © 2018 Atn010. All rights reserved.
//

import UIKit
import AVFoundation

import SwiftSoup

class MusicPlayerVC: UIViewController {
	
	@IBOutlet weak var stationLogo: UIImageView!
	@IBOutlet weak var scrollingTrackName: ScrollText!
	@IBOutlet weak var trackProgressBar: UIProgressView!
	@IBOutlet weak var playPauseButton: UIButton!
	@IBOutlet weak var skipNextButton: UIButton!
	@IBOutlet weak var deadButton: UIButton!
	
	
	
	@IBOutlet weak var testPlayButton: UIButton!
	
	typealias Item = (text: String, html: String)
	
	let player = AudioPlayerObject.shared
	let downloader = FileDownloaderObject.shared
	let directory = FileDownloaderObject.shared
	
	var playStatus:Bool = false
	var loadingStatus:Bool = false
	var bumpList:[String] = [""]
	
	var items: [Item] = []
	var document: Document = Document.init("")
	
	//var music:AVAudioFormat
	
	
	var bgcolor:UIColor = .white
	var acColor:UIColor = .white
	
	var station:String = "Failed"
	var logo:UIImage = UIImage.init(named: "Preloadlogo")!
	
	var track:String = "Here"
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		stationLogo.image = logo
		self.title = station
		initMusicPlayer(trackName: track, bgColor: bgcolor, acColor: acColor)
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(returnToList))
		
		
		
		//testPlayButton.isEnabled = true
		//testPlayButton.setTitle("Loading List", for: .normal)
		//loadingStatus = true
		
		//clearTempFolder()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		initMusicPlayer(trackName: track, bgColor: bgcolor, acColor: acColor)
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
	
	@IBAction func pressedPlayPausedButton(_ sender: UIButton) {
		player.player.play()
		initMusicPlayer(trackName: player.currentTrack, bgColor: bgcolor, acColor: acColor)
	}
	
	@IBAction func onClick(_ sender: UIButton) {
		
		if loadingStatus == true{
			testPlayButton.setTitle("Loading File", for: .normal)
			bumpList.removeFirst()
			
			print(bumpList)
			
			//for fileName in bumpList{
			//let music = "Bump1"
			
			
			
			playStatus = true
			loadingStatus = false
			testPlayButton.setTitle("Plays Bump", for: .normal)
			
			
		}else if playStatus == true{
			print("play Music Here")
			let fileString = "https://jetsetradio.live/audioplayer/stations/bumps/bump1.mp3"
			
			//player.audioURL = downloader.downloadAudioURL(fileStringUrl: fileString, fileStation: "bump")
			

		}
		
		
	}
	
	
	
}

