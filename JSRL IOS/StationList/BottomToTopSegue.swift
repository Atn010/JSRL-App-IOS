//
//  BottomToTopSegue.swift
//  JSRL IOS
//
//  Created by Antonius George on 29/10/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class BottomToTopSegue: UIStoryboardSegue {
	let duration: TimeInterval = 1
	let delay: TimeInterval = 0
	let animationOptions: UIView.AnimationOptions = [.curveEaseInOut]
	
	override func perform() {
		// get views
		let sourceView = source.view
		let destinationView = destination.view
		
		// get screen height
		let screenHeight = UIScreen.main.bounds.size.height
		destinationView!.transform = CGAffineTransform(translationX: 0, y: +screenHeight)
		
		// add destination view to view hierarchy
		UIApplication.shared.keyWindow?.insertSubview(destinationView!, aboveSubview: sourceView!)
		
		// animate
		
		/*
		UIView.animateWithDuration(duration, delay: delay, options: animationOptions, animations: {
			destinationView.transform = CGAffineTransformIdentity
		}) { (_) in
			self.sourceViewController.presentViewController(self.destinationViewController, animated: false, completion: nil)
		}
		*/
		UIView.animate(withDuration: duration, delay: delay, options: animationOptions, animations: {
			destinationView!.transform = .identity
			
			//CGAffineTransformIdentity
		}) { (_) in
			self.source.present(self.destination, animated: false, completion: nil)
		}
		
	}
}
