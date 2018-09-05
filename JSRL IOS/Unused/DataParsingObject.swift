//
//  DataParsingObject.swift
//  JSRL IOS
//
//  Created by Antonius George on 03/09/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit
import SwiftSoup

class DataParsingObject: NSObject {

	static let shared = DataParsingObject()
	
	override private init() {
		items = []
		document = Document.init("")
		
	}
	
	typealias Item = (text: String, html: String)
	
	var items: [Item]
	var document: Document
	
	
	//Download HTML
	func downloadHTML() {
		// url string to URL
		guard let url = URL(string: "https://jetsetradio.live/") else {
			
			return
		}
		
		do {
			// content of url
			let html = try String.init(contentsOf: url)
			// parse it into a Document
			document = try SwiftSoup.parse(html)
			// parse css query
			parse()
		} catch let error {
			// an error occurred
		}
		
	}
	
	//Parse CSS selector
	func parse() {
		do {
			//empty old items
			items = []
			// firn css selector
			let elements: Elements = try document.select("script")
			//transform it into a local object (Item)
			for element in elements {
				let text = try element.text()
				let html = try element.outerHtml()
				items.append(Item(text: text, html: html))
			}
			print(items)
		} catch let error {
			
		}
	}
	
}
