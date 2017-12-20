//
//  ActionSheetPresentationController.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2017/12/4.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class ActionSheetPresentationController: CustomPresentationController {

	override var frameOfPresentedViewInContainerView: CGRect {
		guard let containerView = containerView else { return .zero }
		let containerBounds = containerView.bounds
		let presentedContentsize = size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerBounds.size)
		return CGRect(x: (containerBounds.size.width - presentedContentsize.width) / 2,
						   y: containerBounds.size.height - presentedContentsize.height,
						   width: presentedContentsize.width,
						   height: presentedContentsize.height)
	}
	
	override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.3
	}
	
	override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		
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

		let duration = transitionDuration(using: transitionContext)
		
		if isPresenting {
			// if presentation, will return frameOfPresentedViewInContainerView.
			let finalFrame = transitionContext.finalFrame(for: toViewController)
			let initialFrame = CGRect.init(origin: CGPoint(x: finalFrame.origin.x,
														   y: containerView.bounds.maxY),
										   size: finalFrame.size)
			toView.frame = initialFrame
			containerView.addSubview(toView)
			UIView.animate(withDuration: duration, animations: {
				toView.frame = finalFrame
			}, completion: { _ in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
			
		} else {
			var finalFrame = fromView.frame
			finalFrame.origin.y = containerView.bounds.maxY
			UIView.animate(withDuration: duration, animations: {
				fromView.frame = finalFrame
			}, completion: { _ in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
		}
	}
	
}
