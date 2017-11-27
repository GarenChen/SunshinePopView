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
	
    var contentViewSize: CGSize = .zero
	
	var contentView: UIView? {
		didSet {
			
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		guard let contentView = contentView else { return }
		view.addSubview(contentView)
		let x = (UIScreen.main.bounds.size.width - contentViewSize.width) / 2
		let y = UIScreen.main.bounds.size.height - contentViewSize.height
		contentView.frame = CGRect(x: x, y: y, width: contentViewSize.width, height: contentViewSize.height)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
