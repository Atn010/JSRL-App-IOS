//
//  MusicFile.swift
//  JSRL IOS
//
//  Created by Antonius George on 02/11/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import Foundation

class MusicFile {
	var name:String
	var station:String
	var path:URL?
	
	init(name:String, station:String, path:URL?) {
		self.name = name
		self.station = station
		self.path = path
	}
}
