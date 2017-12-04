//
//  AlertViewType.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2017/12/4.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

public protocol AlertViewType: class {
	func showAsAlertView(size: CGSize, in controller: UIViewController)
	func dismiss()
	var didDisplay: (() -> Void)? { get set }
	var didDismiss: (() -> Void)? { get set }
}

extension AlertViewType where Self: UIView {
	public func showAsAlertView(size: CGSize, in controller: UIViewController) {
		let popController = PopViewController()
		popController.contentView = self
		popController.preferredContentSize = size
		
		let presentationController = AlertViewTypePresentationController(presentedViewController: popController, presenting: controller)
		presentationController.didDismissFromTapBackground = didDismiss
		popController.customTransitioningDelegate = presentationController
		
		controller.present(popController, animated: true, completion: didDisplay)
	}
	
	public func dismiss() {
		self.parentViewController?.dismiss(animated: true, completion: didDismiss)
	}
}
