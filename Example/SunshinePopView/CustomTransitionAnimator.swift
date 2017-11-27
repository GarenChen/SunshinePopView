//
//  CustomTransitionAnimator.swift
//  SunshineBrowser
//
//  Created by Garen on 2017/11/13.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

//	convenience init(placeholderImage: UIImage?, originFrame: CGRect?, destinationFrame: CGRect?) {
//		self.init()
//		self.originFrame = originFrame
//        self.destinationFrame = destinationFrame
//		self.placeholderImage = placeholderImage
//	}
	
	override init() {
		super.init()
	}

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.3
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
			return
		}
        guard let fromView = fromViewController.view else {
            return
        }
        guard let toView = toViewController.view else {
            return
        }
		
		let containerView = transitionContext.containerView

		let isPresenting = toViewController.presentingViewController == fromViewController

        let containerBounds = containerView.bounds

        let duration = transitionDuration(using: transitionContext)

		if isPresenting {
            containerView.addSubview(toView)
			toView.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                toView.alpha = 1
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
			
		} else {
            UIView.animate(withDuration: duration, animations: {
                toView.alpha = 0
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
		}
	}
}
