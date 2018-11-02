//
//  backgroundAudioDownloader.swift
//  JSRL IOS
//
//  Created by Antonius George on 02/11/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit
import CoreData

class AudioDownloader: NSObject {
	
	// Base URL Path
	let jetsetradio = "https://jetsetradio.live/"
	let stationPath = "audioplayer/stations/"
	let extentionPath = ".mp3"
	
	// Station Playlist Path
	//Station Bumps
	let bumpPath = "bumps"
	
	//Soundtrack
	let classicPath = "classic"
	let futurePath = "future"
	
	//Seasonal
	let summerPath = "summer"
	let christmasPath = "christmas"
	
	//Gang
	let ggsPath = "ggs"
	let poisonJamPath = "poisonjam"
	let noiseTanksPath = "noisetanks"
	let loveShockersPath = "loveshockers"
	let rapid99Path = "rapid99"
	let theImmortalsPath = "immortals"
	let doomRidersPath = "doomriders"
	let goldenRhinosPath = "goldenrhinos"
	
	
	// Station Name
	//Station Bumps
	let bump = "Bump"
	
	//Soundtrack
	let classic = "Classic"
	let future = "Future"
	
	//Seasonal
	let summer = "Summer"
	let christmas = "Christmas"
	
	//Gang
	let ggs = "GG's"
	let poisonJam = "Poison Jam"
	let noiseTanks = "Noise Tanks"
	let loveShockers = "Love Shockers"
	let rapid99 = "Rapid 99"
	let theImmortals = "The Immortals"
	let doomRiders = "Doom Riders"
	let goldenRhinos = "Golden Rhinos"

	static let shared = AudioDownloader()
	
	override private init() {
		
	}
	
	let fileDirectoryManager = FileDirectoryObject.shared
	
	func downloadAudioURL(fileStringUrl: String, fileStation: String) {
		if let audioUrl = URL(string: fileStringUrl) {
			
			// then lets create your document folder url
			
			let tempDirectory = FileManager().temporaryDirectory
			let targetDirectory = fileDirectoryManager.makeStationDirectory(station: fileStation)
			let destinationUrl = targetDirectory.appendingPathComponent(audioUrl.lastPathComponent)
			
			// to check if it exists before downloading it
			if FileManager.default.fileExists(atPath: destinationUrl.path) {
				
				// if the file doesn't exist
			} else {
				
				DispatchQueue.global(qos: .userInitiated).sync {
					// you can use NSURLSession.sharedSession to download the data asynchronously
					URLSession.shared.downloadTask(with: audioUrl, completionHandler: { (location, response, error) -> Void in
						guard let location = location, error == nil else { return }
						do {
							// after downloading your file you need to move it to your destination url
							try FileManager.default.moveItem(at: location, to: destinationUrl)
							
							print("File moved to documents folder")
						} catch let error as NSError {
							
							print("something is wrong here")
							print(error.localizedDescription)
						}
					}).resume()
				}
	
				
			}
			
			
		}
		
	}
}
