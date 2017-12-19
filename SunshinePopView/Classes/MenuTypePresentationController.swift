//
//  MenuTypePresentationController.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2017/12/4.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class MenuTypePresentationController: CustomPresentationController {

	var originFrame: CGRect!
	
	deinit {
		print("------ MenuTypePresentationController deinit ---------")
	}
	
	convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, originFrame: CGRect) {
		self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		self.originFrame = originFrame
	}
	
	override var frameOfPresentedViewInContainerView: CGRect {
		guard let containerView = containerView else { return .zero }
		let containerBounds = containerView.bounds
		let presentedContentsize = size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerBounds.size)
		let x = min(originFrame.maxX + 9 - presentedContentsize.width,
					UIScreen.main.bounds.maxX - 7)
		return CGRect(x: x,
					  y: originFrame.maxY,
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
			toView.alpha = 0
			containerView.addSubview(toView)
			UIView.animate(withDuration: duration, animations: {
				toView.alpha = 1
			}, completion: { _ in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
			
		} else {
			UIView.animate(withDuration: duration, animations: {
				fromView.alpha = 0
			}, completion: { _ in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			})
		}
	}
}
