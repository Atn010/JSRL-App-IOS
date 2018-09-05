//
//  RealmManager.swift
//  JSRL IOS
//
//  Created by Antonius George on 04/09/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
	let realm = try? Realm()
	
	// delete table
	
	// delete particular object
	func deleteObject(objs : Object) {
		try? realm!.write ({
			realm?.delete(objs)
		})
	}
	
	//Save array of objects to database
	func saveObjects(objs: Object) {
		try? realm!.write ({
			// If update = false, adds the object
			realm?.add(objs, update: false)
		})
	}
	
	// editing the object
	func editObjects(objs: Object) {
		try? realm!.write ({
			// If update = true, objects that are already in the Realm will be
			// updated instead of added a new.
			realm?.add(objs, update: true)
		})
	}
	
	//Returs an array as Results<object>?
	func getObjects(type: Object.Type) -> Results<Object>? {
		return realm!.objects(type)
	}
	
	func incrementID() -> Int {
		return (realm!.objects(FileObject.self).max(ofProperty: "id") as Int? ?? 0) + 1
	}
	
	
}
