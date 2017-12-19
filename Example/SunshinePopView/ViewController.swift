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

		view.showAsAlertView(size: CGSize.init(width: 200, height: 200), in: self)
	}
	
	@IBAction func popActionSheet(_ sender: UIButton) {
		let view = CustomActionSheetView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))

		view.showAsActionSheet(size: CGSize.init(width: UIScreen.main.bounds.size.width - 4, height: 200), in: self)

	}
	
	@IBAction func popMenu(_ sender: UIButton) {
		let view = CustomMenuView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))

		view.didClick = { [weak self] in
			self?.navigationController?.pushViewController(ThirdViewController(), animated: true)
		}
		view.showAsMenu(size: CGSize.init(width: 200, height: 200), originFrame: sender.frame, in: self)
	}

}

class CustomActionSheetView: UIView, ActionSheetType {
	
	var didTapBackground: (() -> Void)?

	var didClick: (() -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .red
		self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click)))
		self.didTapBackground = { [weak self] in
			self?.dismiss()
		}
	}
	
	@objc func click() {
		dismiss()
		didClick?()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class CustomAlertView: UIView, AlertViewType {
	
	var didTapBackground: (() -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .red
		self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click)))
		self.didTapBackground = { [weak self] in
			self?.dismiss()
		}
	}
	
	@objc func click() {
		dismiss()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class CustomMenuView: UIView, MenuType {
	
	var didTapBackground: (() -> Void)?
	
	var didClick: (() -> Void)?
	
	var dimmingViewColor: UIColor {
		return UIColor(white: 0, alpha: 0.3)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .red
		self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(click)))
		self.didTapBackground = { [weak self] in
			self?.dismiss()
		}
	}
	
	@objc func click() {
		dismiss(animated: true, completion: didClick)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


