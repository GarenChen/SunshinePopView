//
//  CustomPresentationController
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/14.
//  Copyright © 2017年 cgc. All rights reserved.
//

import Foundation
import UIKit

public class CustomPresentationController: UIPresentationController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
	
	/// default is true
	public var shouldDismissWhenTapBackground: Bool {
		return true
	}
	
	public var dimmingViewColor: UIColor = UIColor(white: 0, alpha: 0.5)
	
	public var didTapBackground: (() -> Void)?
	
	lazy var dimmingView: UIView = { [unowned self] in
        let dimmingView = UIView()
        dimmingView.backgroundColor = self.dimmingViewColor
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmingView(_:))))
        return dimmingView
    }()
	
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		presentedViewController.modalPresentationStyle = UIModalPresentationStyle.custom
    }
    
	public override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.addSubview(dimmingView)
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContex) in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    public override func dismissalTransitionWillBegin() {
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coodinatorContex) in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    
    public override func containerViewWillLayoutSubviews() {
		super.containerViewWillLayoutSubviews()
        guard let containerView = containerView else { return }
        dimmingView.frame = containerView.bounds
		presentedView?.frame = self.frameOfPresentedViewInContainerView
    }

	public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
		super.preferredContentSizeDidChange(forChildContentContainer: container)
		if let currentController = (container as? UIViewController), currentController == self.presentedViewController {
			self.containerView?.setNeedsLayout()
		}
	}
	
	public override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
		if let currentController = (container as? UIViewController), currentController == self.presentedViewController {
			return currentController.preferredContentSize
		}
		return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
	}
    
    @objc private func didTapDimmingView(_ sender: UITapGestureRecognizer) {
		didTapBackground?()
    }
	
	// MARK: - UIViewControllerAnimatedTransitioning
	public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		fatalError("need to override ")
	}
	
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		fatalError("need to override ")
	}
	
	//	MARK: - UIViewControllerTransitioningDelegate
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self
	}
	
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self
	}
	
	public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		return self
	}
    
}

