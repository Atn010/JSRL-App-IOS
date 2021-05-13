//
//  navbarButtons.swift
//  JSRL IOS
//
//  Created by Antonius George S on 13/05/21.
//  Copyright © 2021 Atn010.com. All rights reserved.
//

import UIKit

public extension UIViewController {
	func addLeftBarButtonItem(image: UIImage?, tintColor: UIColor = .white, selector: Selector) {
		let barButtonItem = UIBarButtonItem(
			image: image,
			style: .plain,
			target: self,
			action: selector
		)
		addLeftBarButtonItem(barButtonItem, tintColor: tintColor)
	}
	
	func addRightBarButtonItem(image: UIImage?, tintColor: UIColor = .white, selector: Selector) {
		let barButtonItem = UIBarButtonItem(
			image: image,
			style: .plain,
			target: self,
			action: selector
		)
		addRightBarButtonItem(barButtonItem, tintColor: tintColor)
	}
	
	@objc func dismissPage() {
		self.dismiss(animated: true, completion: nil)
	}
	
	@objc func backToPreviousPage() {
		self.navigationController?.popViewController(animated: true)
	}
	
	func addLeftBarButtonItem(_ item: UIBarButtonItem, tintColor: UIColor) {
		
		item.tintColor = tintColor
		
		guard let items = navigationItem.leftBarButtonItems, items.count > 0 else {
			navigationItem.leftBarButtonItem = item
			return
		}
		
		navigationItem.leftBarButtonItems?.append(item)
	}
	
	func addRightBarButtonItem(_ item: UIBarButtonItem, tintColor: UIColor? = nil) {
		
		if let tintColor = tintColor {
			item.tintColor = tintColor
		}
		
		guard let items = navigationItem.rightBarButtonItems, items.count > 0 else {
			navigationItem.rightBarButtonItem = item
			return
		}
		
		navigationItem.rightBarButtonItems?.append(item)
	}
}

