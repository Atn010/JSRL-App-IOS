//
//  FadeAnimationController.swift
//  CustomTransitionDemo
//
//  Created by Ludvig Eriksson on 2018-01-22.
//  Copyright © 2018 Ludvig Eriksson. All rights reserved.
//

import UIKit

class FadeAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private let presenting: Bool

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        let container = transitionContext.containerView
        if presenting {
			
            container.addSubview(toView)
			//toView.alpha = 0
            toView.transform = CGAffineTransform.init(translationX: 0, y: fromView.frame.maxY)
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }

		
		UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .transitionCurlUp, animations: {
			if self.presenting {
				//toView.alpha = 1.0
				toView.transform = fromView.transform
				fromView.transform = .init(scaleX: 0.9, y: 0.9)
			} else {
				//fromView.alpha = 0.0
				fromView.transform = CGAffineTransform.init(translationX: 0, y: toView.frame.maxY)
			}
		}) { _ in
			let success = !transitionContext.transitionWasCancelled
			if !success {
				toView.removeFromSuperview()
			}
			fromView.transform = toView.transform
			transitionContext.completeTransition(success)
		}
/*
		UIView.animate(withDuration: transitionDuration(using: transitionContext), options: .curveEaseInOut, animations: {
            if self.presenting {
                toView.alpha = 1.0
				toView.transform = fromView.transform
            } else {
                fromView.alpha = 0.0
            }
		}) { _ in
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }
*/
    }

    init(presenting: Bool) {
        self.presenting = presenting
    }
}

