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
	func dismiss()
	var didDisplay: (() -> Void)? { get set }
	var didDismiss: (() -> Void)? { get set }
}

extension ActionSheetType where Self: UIView {
	public func showAsActionSheet(size: CGSize, in controller: UIViewController) {
		let popController = PopViewController()
		popController.contentView = self
		popController.preferredContentSize = size
		
		let presentationController = ActionSheetPresentationController(presentedViewController: popController, presenting: controller)
		presentationController.didDismissFromTapBackground = didDismiss
		popController.customTransitioningDelegate = presentationController
		
		controller.present(popController, animated: true, completion: didDisplay)
	}
	
	public func dismiss() {
		self.parentViewController?.dismiss(animated: true, completion: didDismiss)
	}
}
