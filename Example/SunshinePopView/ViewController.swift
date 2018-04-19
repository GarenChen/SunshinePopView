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
		
		let alertView = AlertView.init(title: "标题标题标题", detail: "详情detailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetails", cancelButtonTitle: "取消", otherButtonTitles: ["非常好", "好", "不太好", "很不好"])
		view.addSubview(alertView)
		alertView.snp.makeConstraints({
			$0.left.right.bottom.equalToSuperview()
		})
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func popAlertView(_ sender: UIButton) {
//		let view = CustomAlertView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
		let alertView = AlertView.init(title: "标题标题标题", detail: "详情detailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetailsdetails", cancelButtonTitle: "取消", otherButtonTitles: ["非常好", "好", "不太好", "很不好"])
		let size = alertView.systemLayoutSizeFitting(CGSize.init(width: UIScreen.main.bounds.width - 30, height: CGFloat.infinity), withHorizontalFittingPriority: UILayoutPriority.defaultHigh, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)
		alertView.backgroundColor = .white
		alertView.showAsAlertView(size: size, in: self)
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
		view.show(as: .menu(sender.frame), size: CGSize.init(width: 200, height: 200), in: self)
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

extension AlertView: AlertViewType {
	
	var didTapBackground: (() -> Void)? {
		get {
			return { [weak self] in
				self?.dismiss()
			}
		}
		set(newValue) {
			
		}
	}
	
	
}


class CustomAlertView: UIView,AlertViewType  {
	
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

class CustomMenuView: UIView, PopViewShowType {
	
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


