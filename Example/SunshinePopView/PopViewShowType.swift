//
//  PopViewShowType.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2017/11/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

protocol ActionSheet: class {
	
	func showAsActionSheet(size: CGSize, in controller: UIViewController)
	func dismiss()
	
	var didDisplay: (() -> Void)? { get set }
	var didDismiss: (() -> Void)? { get set }
}

extension ActionSheet where Self: UIView {
	
	func showAsActionSheet(size: CGSize, in controller: UIViewController) {
		let popController = PopViewController()
		popController.contentView = self
		popController.contentViewSize = size
		popController.modalPresentationStyle = .custom
		popController.customTransitioningDelegate =  CustomTransitionDelegate()
		controller.present(popController, animated: true, completion: didDisplay)
	}
	
	func dismiss() {
		self.parentViewController?.dismiss(animated: true, completion: didDismiss)
	}
}
