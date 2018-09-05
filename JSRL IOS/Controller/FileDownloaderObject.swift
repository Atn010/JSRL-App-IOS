//
//  FileDownloaderObject.swift
//  JSRL IOS
//
//  Created by Antonius George on 04/09/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class FileDownloaderObject: NSObject {

	static let shared = FileDownloaderObject()
	
	override private init() {
		
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
