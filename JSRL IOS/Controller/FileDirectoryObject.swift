//
//  FileDirectoryObject.swift
//  JSRL IOS
//
//  Created by Antonius George on 04/09/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class FileDirectoryObject: NSObject {
	static let shared = FileDirectoryObject()
	
	override private init() {
		fileManager = FileManager.default
		documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
		appURL = documentsURL.appendingPathComponent("JSRLiOS")
		stationURL = appURL.appendingPathComponent("Station")
		imageURL = appURL.appendingPathComponent("Image")
		
		
	}
	let fileManager:FileManager
	let documentsURL: URL
	let appURL:URL
	let stationURL:URL
	let imageURL:URL
	
	func makeStationDirectory(station:String) -> URL {
		return URL.createFolder(folderName: "JSRLiOS/Station/\(station)")!
	}
	
	
	func clearTempFolder() {
		
		
		let fileManager = FileManager.default
		let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
		let appURL = documentsURL.appendingPathComponent("JSRLiOS")
		
		print("Document Folder")
		print(fileManager.listFiles(path: documentsURL.absoluteString))
		print("")
		
		print("JSRLiOS Folder")
		print(fileManager.listFiles(path: appURL.absoluteString))
		
		//let fileManager = FileManager.default
		//let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		do {
			let fileURLs = try fileManager.contentsOfDirectory(at: appURL, includingPropertiesForKeys: nil)
			print(fileURLs)
			// process files
		} catch {
			print("Error while enumerating files \(appURL.path): \(error.localizedDescription)")
		}
		
		/*
		do {
		print("Trying folder")
		print()
		let fileURLs = try fileManager.contentsOfDirectory(at: appURL, includingPropertiesForKeys: nil)
		//try fileManager.contentsOfDirectory(at: appURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
		//try fileManager.contentsOfDirectory(atPath: appURL.absoluteString)
		//try fileManager.contentsOfDirectory(at: appURL, includingPropertiesForKeys: nil)
		// process files
		//print(fileURLs)
		print("")
		
		for itemPath in fileURLs {
		print(itemPath)
		print("")
		print("")
		//let fullPath = documentsURL.appendingPathComponent(itemPath.absoluteString )
		do{
		//print(itemPath)
		print("")
		print("")
		print("")
		try fileManager.removeItem(at: itemPath)
		}catch{
		print("unable to Delete")
		}
		
		}
		
		
		} catch {
		print("Error while enumerating files \n\(appURL.absoluteString): \n\(error.localizedDescription)")
		}
		
		*/
		
		
	}
	
}

extension FileManager {
	func listFiles(path: String) -> [URL] {
		let baseurl: URL = URL(fileURLWithPath: path)
		var urls = [URL]()
		enumerator(atPath: path)?.forEach({ (e) in
			guard let s = e as? String else { return }
			let relativeURL = URL(fileURLWithPath: s, relativeTo: baseurl)
			let url = relativeURL.absoluteURL
			urls.append(url)
		})
		return urls
	}
}

extension URL {
	static func createFolder(folderName: String) -> URL? {
		let fileManager = FileManager.default
		// Get document directory for device, this should succeed
		if let documentDirectory = fileManager.urls(for: .documentDirectory,
													in: .userDomainMask).first {
			// Construct a URL with desired folder name
			let folderURL = documentDirectory.appendingPathComponent(folderName)
			// If folder URL does not exist, create it
			if !fileManager.fileExists(atPath: folderURL.path) {
				do {
					// Attempt to create folder
					try fileManager.createDirectory(atPath: folderURL.path,
													withIntermediateDirectories: true,
													attributes: nil)
				} catch {
					// Creation failed. Print error & return nil
					print(error.localizedDescription)
					return nil
				}
			}
			// Folder either exists, or was created. Return URL
			return folderURL
		}
		// Will only be called if document directory not found
		return nil
	}
}
