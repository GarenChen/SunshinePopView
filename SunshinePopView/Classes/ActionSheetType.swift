//
//  ActionSheetType.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2017/12/4.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

public protocol ActionSheetType: class {
	func showAsActionSheet(size: CGSize, in controller: UIViewController)
	func dismiss(animated: Bool, completion: (() ->Void)?)
	var dimmingViewColor: UIColor { get }
	var didTapBackground: (() -> Void)? { get set }
}

extension ActionSheetType where Self: UIView {
	
	public var dimmingViewColor: UIColor {
		return UIColor(white: 0, alpha: 0.5)
	}
	
	public func showAsActionSheet(size: CGSize, in controller: UIViewController) {
		let popController = PopViewController()
		popController.contentView = self
		popController.preferredContentSize = size
		
		let presentationController = ActionSheetPresentationController(presentedViewController: popController, presenting: controller)
		presentationController.didTapBackground = didTapBackground
		presentationController.dimmingViewColor = dimmingViewColor
		popController.transitioningDelegate = presentationController
		
		controller.present(popController, animated: true, completion: nil)
	}
	
	public func dismiss(animated: Bool = true, completion: (() ->Void)? = nil) {
		self.parentViewController?.dismiss(animated: animated, completion: completion)
	}
}
