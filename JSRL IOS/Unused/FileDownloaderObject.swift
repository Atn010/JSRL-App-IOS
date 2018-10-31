//
//  FileDownloaderObject.swift
//  JSRL IOS
//
//  Created by Antonius George on 04/09/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit
import CoreData

class FileDownloaderObject: NSObject {

	static let shared = FileDownloaderObject()
	
	override private init() {
		
	}
	
	
	let fileDirectoryManager = FileDirectoryObject.shared
	
	func downloadAudioURL(fileStringUrl: String, fileStation: String) -> String {
		if let audioUrl = URL(string: fileStringUrl) {
			
			// then lets create your document folder url
			
			
			let targetDirectory = fileDirectoryManager.makeStationDirectory(station: fileStation)
			let destinationUrl = targetDirectory.appendingPathComponent(audioUrl.lastPathComponent)
			
			// to check if it exists before downloading it
			if FileManager.default.fileExists(atPath: destinationUrl.path) {
				print("The file already exists at path")
				
				return destinationUrl.absoluteString
				
				// if the file doesn't exist
			} else {
				let group = DispatchGroup()
				group.enter()
				
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
					
					group.wait()
				return destinationUrl.absoluteString
				
			}
			
			
		}else{
			return "nil"
		}
		
	}
	
	func downloadList(fileUrl:String) -> [String] {
		let url = URL(string: fileUrl)!
		var fileList:[String] = []
		
		let group = DispatchGroup()
		group.enter()

		DispatchQueue.global(qos: .userInitiated).sync {
			URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
				if let localURL = localURL {
					if let string = try? String(contentsOf: localURL) {
						
						var lines: [String] = []
						string.enumerateLines { line, _ in
							lines.append(line)
						}
						for line in lines{
							fileList.append(line.components(separatedBy: "\"")[1])
						}
						
						
					}
				}
			}.resume()
		}

		   group.wait()
		
		return fileList
		
	}
}
