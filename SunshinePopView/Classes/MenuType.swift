//
//  MenuType.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2017/11/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

public protocol MenuType: class {
	func showAsMenu(size: CGSize, originFrame: CGRect, in controller: UIViewController)
	func dismiss()
	var didDisplay: (() -> Void)? { get set }
	var didDismiss: (() -> Void)? { get set }
}

extension MenuType where Self: UIView {
	public func showAsMenu(size: CGSize, originFrame: CGRect, in controller: UIViewController) {
		let popController = PopViewController()
		popController.contentView = self
		popController.preferredContentSize = size
		
		let presentationController = MenuTypePresentationController(presentedViewController: popController, presenting: controller, originFrame: originFrame)

		presentationController.didDismissFromTapBackground = didDismiss
		popController.customTransitioningDelegate = presentationController
		
		controller.present(popController, animated: true, completion: didDisplay)
	}
	
	public func dismiss() {
		self.parentViewController?.dismiss(animated: true, completion: didDismiss)
	}
}
