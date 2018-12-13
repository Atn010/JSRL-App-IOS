//
//  CustomNavigationTransition.swift
//  JSRL IOS
//
//  Created by Antonius George on 11/12/18.
//  Copyright © 2018 Atn010.com. All rights reserved.
//

import UIKit

class CustomNavigationTransition: UINavigationController {

	private var interactionController: UIPercentDrivenInteractiveTransition?
	private var edgeSwipeGestureRecognizer: UISwipeGestureRecognizer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegate = self
		
		edgeSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
		edgeSwipeGestureRecognizer!.direction = .down
		view.addGestureRecognizer(edgeSwipeGestureRecognizer!)
	}
	
	@objc func handleSwipe(_ gestureRecognizer: UISwipeGestureRecognizer) {
		
		if gestureRecognizer.state == .began {
			interactionController = UIPercentDrivenInteractiveTransition()
			popViewController(animated: true)
		} else if gestureRecognizer.state == .changed {
			//interactionController?.update(percent)
		} else if gestureRecognizer.state == .ended {
			//if percent > 0.5 && gestureRecognizer.state != .cancelled {
				interactionController?.finish()
			//} else {
			//	interactionController?.cancel()
			//}
			interactionController = nil
		}
	}
}

extension CustomNavigationTransition: UINavigationControllerDelegate {
	func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		if operation == .push {
			return FadeAnimationController(presenting: true)
		} else {
			return FadeAnimationController(presenting: false)
		}
	}
	
	func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return interactionController
	}
}
