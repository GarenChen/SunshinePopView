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
    }

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		contentView?.frame = self.view.bounds
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
