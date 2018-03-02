//
//  PopViewController.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2017/11/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {
	
	var customTransitioningDelegate: UIViewControllerTransitioningDelegate? {
		didSet {
			self.transitioningDelegate = customTransitioningDelegate
		}
	}
	
	deinit {
		print("------ PopViewController deinit ---------")
	}

	var contentView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
		guard let contentView = contentView else { return }
		view.addSubview(contentView)
		view.addConstraints([
			NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0),
			NSLayoutConstraint.init(item: contentView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
			])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
