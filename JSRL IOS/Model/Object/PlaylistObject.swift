//
//  Playlist.swift
//  JSRL IOS
//
//  Created by Antonius George on 05/09/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class PlaylistObject: NSObject {
	
	static let shared = PlaylistObject()
	private override init() {
		musicPlaylist = []
		
	}
	var musicPlaylist:[String]
	
	func MakePlaylist() {
		
	}

}
