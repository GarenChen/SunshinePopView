//
//  ShowType.swift
//  Pods-SunshinePopView_Example
//
//  Created by 陈广川 on 2017/12/20.
//

import UIKit

public enum ContentShowType {
	case alert
	case actionSheet
	case menu(CGRect)
}

public protocol PopViewShowType: class {
	func show(as contentType: ContentShowType, size: CGSize, in controller: UIViewController)
	func dismiss(animated: Bool, completion: (() ->Void)?)
	var dimmingViewColor: UIColor { get }
	var didTapBackground: (() -> Void)? { get set }
}

extension PopViewShowType where Self: UIView {
	
	public var dimmingViewColor: UIColor {
		return UIColor(white: 0, alpha: 0.5)
	}
	
	public func show(as contentType: ContentShowType, size: CGSize, in controller: UIViewController) {
		let popController = PopViewController()
		popController.contentView = self
		popController.preferredContentSize = size
		
		let presentationController: CustomPresentationController = {
			switch contentType {
			case .alert:
				return AlertViewTypePresentationController(presentedViewController: popController, presenting: controller)
			case .actionSheet:
				return ActionSheetPresentationController(presentedViewController: popController, presenting: controller)
			case .menu(let originFrame):
				return MenuTypePresentationController(presentedViewController: popController, presenting: controller, originFrame: originFrame)
			}
		}()
		presentationController.didTapBackground = didTapBackground
		presentationController.dimmingViewColor = dimmingViewColor
		popController.transitioningDelegate = presentationController
		controller.present(popController, animated: true, completion: nil)
	}
	
	public func dismiss(animated: Bool = true, completion: (() ->Void)? = nil) {
		self.parentViewController?.dismiss(animated: animated, completion: completion)
	}
}



