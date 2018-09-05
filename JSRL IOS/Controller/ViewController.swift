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
		

		
		testPlayButton.isEnabled = true
		testPlayButton.setTitle("Loading List", for: .normal)
		loadingStatus = true
		
		//clearTempFolder()

		/*
			let url = URL(string: "https://jetsetradio.live/audioplayer/stations/bumps/~list.js")!
			
			var text = ""
			
			let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
				if let localURL = localURL {
					if let string = try? String(contentsOf: localURL) {
						//let subString = string.split( isSeparator:  )[1]
						//print(string)
						
						text = string
						var lines: [String] = []
						text.enumerateLines { line, _ in
							lines.append(line)
						}
						for line in lines{
							self.bumpList.append(line.components(separatedBy: "\"")[1])
						}
						self.loadingStatus = true
					
						
					}
				}
			}
			task.resume()
		
*/
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
					if let audioUrl = URL(string: "https://jetsetradio.live/audioplayer/stations/bumps/bump2.mp3") {
						
						// then lets create your document folder url
						let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
						
						// lets create your destination file url
						let appURL = documentsDirectoryURL.appendingPathComponent("JSRLiOS")
						let destinationUrl = appURL.appendingPathComponent(audioUrl.lastPathComponent)
						
						_ = URL.createFolder(folderName: "JSRLiOS")
						
						//appURL.documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
						//print(destinationUrl)
						
						// to check if it exists before downloading it
						if FileManager.default.fileExists(atPath: destinationUrl.path) {
							print("The file already exists at path")
							
							self.player.audioURL = destinationUrl
							

							
							
							
							// if the file doesn't exist
						} else {
							
							URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) in
								//guard let location = location, error == nil else { return }
								print("Doing")
								if  let file = location {
									print("Moving File")
									self.player.audioURL = file
									print(self.player.audioURL)
								}else{
									print(error ?? "None")
								}

							})
							
							
							// you can use NSURLSession.sharedSession to download the data asynchronously
							URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
								guard let location = location, error == nil else { return }
								do {
									// after downloading your file you need to move it to your destination url
									try FileManager.default.moveItem(at: location, to: destinationUrl)
									
									self.player.audioURL = destinationUrl
									print("File moved to documents folder")
								} catch let error as NSError {
									
									print("something is wrong here")
									print(error.localizedDescription)
								}
							}).resume()
						}
					
				//}
			}
			playStatus = true
			loadingStatus = false
			testPlayButton.setTitle("Plays Bump", for: .normal)
			
			
		}else if playStatus == true{
			print("play Music Here")
			print(player.audioURL)
			
			

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

