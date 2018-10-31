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
    
    override func viewDidLoad() {
        super.viewDidLoad()
		//player.delegate = self
		

		
		//testPlayButton.isEnabled = true
		//testPlayButton.setTitle("Loading List", for: .normal)
		loadingStatus = true
		
		//clearTempFolder()
        // Do any additional setup after loading the view, typically from a nib.
    }

	
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

			do{
				
			player.audioPlayer = try AVAudioPlayer(contentsOf: self.player.audioURL, fileTypeHint: ".mp3")
			
			player.audioPlayer.numberOfLoops = -1
			player.audioPlayer.play()
				
			}catch{
				print("Error here")
			}
    }

		
	}



}

