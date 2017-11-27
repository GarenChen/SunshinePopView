//
//  PopType.swift
//  Pods-SunshinePopView_Example
//
//  Created by 陈广川 on 2017/11/27.
//

import Foundation

enum MenuDisplayType {
	case left
	case right
	case center
}

enum PopType {
	case alert
	case actionSheet
	case menu(MenuDisplayType)
}
