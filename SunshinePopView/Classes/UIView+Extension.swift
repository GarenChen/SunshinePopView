//
//  UIView+Extension.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2017/11/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
	var parentViewController: UIViewController? {
		get {
			var nextResponder = self.next
			while nextResponder != nil  {
				if let nextResponder = nextResponder as? UIViewController {
					return nextResponder
				}
				nextResponder = nextResponder?.next
			}
			return nil
		}
	}
}
