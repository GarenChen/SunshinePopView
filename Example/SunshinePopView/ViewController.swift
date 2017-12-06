//
//  ViewController.swift
//  SunshinePopView
//
//  Created by GarenChen on 11/27/2017.
//  Copyright (c) 2017 GarenChen. All rights reserved.
//

import UIKit
import SunshinePopView

class ViewController: UIViewController {

	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func popAlertView(_ sender: UIButton) {
		let view = CustomAlertView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
		view.didDisplay = {
			print("did display")
		}
		view.didDismiss = {
			print("did dismiss")
		}
		view.showAsAlertView(size: CGSize.init(width: 200, height: 200), in: self)
	}
	
	@IBAction func popActionSheet(_ sender: UIButton) {
		let view = CustomActionSheetView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
		view.didDisplay = {
			print("did display")
		}
		view.didDismiss = {
			print("did dismiss")
		}
		view.showAsActionSheet(size: CGSize.init(width: 200, height: 200), in: self)

	}
	
	@IBAction func popMenu(_ sender: UIButton) {
		let view = CustomMenuView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
		view.didDisplay = {
			print("did display")
		}
		view.didDismiss = {
			print("did dismiss")
		}
		view.showAsMenu(size: CGSize.init(width: 200, height: 200), originFrame: sender.frame, in: self)
	}

}

class CustomActionSheetView: UIView, ActionSheetType {

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

class CustomAlertView: UIView, AlertViewType {

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

class CustomMenuView: UIView, MenuType {

	var didDisplay: (() -> Void)?
	
	var didDismiss: (() -> Void)?
	
	var dimmingViewColor: UIColor {
		return UIColor(white: 0, alpha: 0.3)
	}
	
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


