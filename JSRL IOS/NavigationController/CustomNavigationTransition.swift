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
	private var edgeSwipeGestureRecognizer: UIPanGestureRecognizer?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		delegate = self
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
