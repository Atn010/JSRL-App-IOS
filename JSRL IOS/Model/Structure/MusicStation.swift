//
//  MusicStation.swift
//  JSRL IOS
//
//  Created by Antonius George on 30/10/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class MusicStation{
	var name:String
	var logo:UIImage
	var bgLogoColor:UIColor
	var acLogoColor:UIColor
	
	init(name:String,logo:UIImage,bgLogoColor:UIColor,acLogoColor:UIColor) {
		self.name = name
		self.logo = logo
		self.bgLogoColor = bgLogoColor
		self.acLogoColor = acLogoColor
	}
}
