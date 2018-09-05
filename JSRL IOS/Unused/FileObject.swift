//
//  Audio.swift
//  JSRL IOS
//
//  Created by Antonius George on 04/09/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import Foundation
import RealmSwift

class FileObject: Object{
	
	@objc dynamic var id:Int = 0
	@objc dynamic var fileName:String = ""
	@objc dynamic var fileStat:String? = nil
	@objc dynamic var filePath:String? = nil
	@objc dynamic var fileType:String? = nil

	override static func primaryKey() -> String? {
		return "id"
	}
	
	convenience init(id : Int, fileName: String, fileStat:String?, filePath:String?, fileType:String?) {
		self.init()
		self.id = id
		self.fileName = fileName
		self.fileStat = fileStat
		self.filePath = filePath
		self.fileType = fileType
	}
}
