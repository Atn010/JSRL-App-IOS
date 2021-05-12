//
//  MusicStation.swift
//  JSRL IOS
//
//  Created by Antonius George on 30/10/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

struct MusicStation {
	var name: StationListInfo.Name
	var desc: StationListInfo.Desc
	var logo: UIImage
	var accent: UIColor
	
	init(name: StationListInfo.Name, desc: StationListInfo.Desc, logo: UIImage, accent: UIColor) {
		self.name = name
		self.desc = desc
		self.logo = logo
		self.accent = accent
	}
}
