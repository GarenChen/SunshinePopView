//
//  CustomTransitionDelegate.swift
//  SunshineBrowser
//
//  Created by Garen on 2017/11/13.
//  Copyright © 2017年 cgc. All rights reserved.
//

import UIKit

class CustomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

//    private var originFrame: CGRect?
//
//    private var destinationFrame: CGRect?
//
//    private var placeholderImage: UIImage?
	
	override init() {
		super.init()
	}

//    convenience init(placeholderImage: UIImage?, originFrame: CGRect?, destinationFrame: CGRect?) {
//        self.init()
//        self.originFrame = originFrame
//        self.destinationFrame = destinationFrame
//        self.placeholderImage = placeholderImage
//    }
//
//    func changePlaceholder(_ placeholderImage: UIImage?) {
//        self.placeholderImage = placeholderImage
//    }
//
//    func changeDestinationFrame(_ destinationFrame: CGRect?) {
//        self.destinationFrame = destinationFrame
//    }
//
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return CustomTransitionAnimator()
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return CustomTransitionAnimator()
	}
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }

}
