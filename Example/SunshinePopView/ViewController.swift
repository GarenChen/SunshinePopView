//
//  ViewController.swift
//  SunshinePopView
//
//  Created by GarenChen on 11/27/2017.
//  Copyright (c) 2017 GarenChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let view = CustomView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
		view.didDisplay = {
			print("did display")
		}
		
		view.didDismiss = {
			print("did dismiss")
		}
		
		view.showAsActionSheet(size: CGSize.init(width: 200, height: 200), in: self)
	}

}

class CustomView: UIView, ActionSheet {

	var didDisplay: (() -> Void)?
	
	var didDismiss: (() -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .red
		self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click)))
	}
	
	@objc func click() {
		dismiss()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

