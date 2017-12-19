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
	func dismiss(animated: Bool, completion: (() ->Void)?)
	var dimmingViewColor: UIColor {get}
	var didTapBackground: (() -> Void)? { get set }
}

extension MenuType where Self: UIView {
	
	public var dimmingViewColor: UIColor {
		return UIColor(white: 0, alpha: 0.1)
	}
	
	public func showAsMenu(size: CGSize, originFrame: CGRect, in controller: UIViewController) {
		let popController = PopViewController()
		popController.contentView = self
		popController.preferredContentSize = size
		
		let presentationController = MenuTypePresentationController(presentedViewController: popController, presenting: controller, originFrame: originFrame)

		presentationController.didTapBackground = didTapBackground
		presentationController.dimmingViewColor = dimmingViewColor
		popController.transitioningDelegate = presentationController
		
		controller.present(popController, animated: true, completion: nil)
	}
	
	public func dismiss(animated: Bool = true, completion: (() ->Void)? = nil) {
		self.parentViewController?.dismiss(animated: animated, completion: completion)
	}
}
