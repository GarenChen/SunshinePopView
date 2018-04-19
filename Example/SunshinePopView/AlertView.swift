//
//  AlertView.swift
//  SunshinePopView_Example
//
//  Created by 陈广川 on 2018/4/19.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class AlertView: UIView {
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = UIColor.black
		label.textAlignment = .center
		label.numberOfLines = 0
		label.backgroundColor = .green
		return label
	}()
	
	private lazy var detailLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = UIColor.black
		label.textAlignment = .center
		label.numberOfLines = 0
		label.backgroundColor = .lightGray
		return label
	}()
	
	private var buttons: [AlertViewButton] = []
	
	private var title: String?
	private var detail: String?
	private var cancelButtonTitle: String?
	private var otherButtonTitles: [String] = []
	
	///点击按钮的回调，参数：（type， index， title），如果点击了cancel按钮，回调的index为-1
	var didSelected: ((AlertViewButton.AlertViewButtonType, Int, String) -> Void)?
	
	convenience init(title: String? = nil,
					 detail: String? = nil,
					 cancelButtonTitle: String? = nil,
					 otherButtonTitles: [String]) {
		self.init(frame: .zero)
		self.title = title
		self.detail = detail
		self.cancelButtonTitle = cancelButtonTitle
		self.otherButtonTitles = otherButtonTitles
		setupViews()
		layoutViews()
	}
	
	private func setupViews() {
		if let title = self.title, !title.isEmpty {
			titleLabel.text = title
		}
		if let detail = self.detail, !detail.isEmpty {
			detailLabel.text = detail
		}
		if let cancelTitle = cancelButtonTitle, !cancelTitle.isEmpty {
			buttons.append(AlertViewButton.init(title: cancelTitle, type: .cancel))
		}
		for (index, title) in otherButtonTitles.enumerated() {
			let button = AlertViewButton.init(title: title, type: .confirm)
			button.tag = index
			button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
			buttons.append(button)
		}
	}
	
	private func layoutViews() {
		
		var lastTopView: UIView = self
		
		if let title = self.title, !title.isEmpty {
			addSubview(titleLabel)
			titleLabel.snp.makeConstraints({
				$0.top.equalTo(lastTopView).offset(16)
				$0.left.equalToSuperview().offset(30)
				$0.right.equalToSuperview().offset(-30)
			})
			lastTopView = titleLabel
		}
		if let detail = self.detail, !detail.isEmpty {
			addSubview(detailLabel)
			detailLabel.snp.makeConstraints({
				$0.top.equalTo(lastTopView.snp.bottom).offset(16)
				$0.left.equalToSuperview().offset(20)
				$0.right.equalToSuperview().offset(-20)
			})
			lastTopView = detailLabel
		}
		
		var lastLeftView: UIView = self
		for (index, button) in buttons.enumerated() {
			addSubview(button)
			if index == 0 {
				button.snp.makeConstraints({
					$0.top.equalTo(lastTopView.snp.bottom).offset(16)
					$0.height.equalTo(40)
					$0.left.equalTo(lastLeftView).offset(15)
					$0.bottom.equalToSuperview().offset(-15)
				})
				if buttons.count == 1 {
					button.snp.makeConstraints({
						$0.right.equalToSuperview().offset(-15)
					})
				}
				lastLeftView = button
			} else if index == buttons.count - 1 {
				button.snp.makeConstraints({
					$0.top.height.width.equalTo(lastLeftView)
					$0.left.equalTo(lastLeftView.snp.right).offset(15)
					$0.right.equalToSuperview().offset(-15)
				})
				lastLeftView = button
			} else {
				button.snp.makeConstraints({
					$0.top.height.width.equalTo(lastLeftView)
					$0.left.equalTo(lastLeftView.snp.right).offset(15)
				})
				lastLeftView = button
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc private func clickButton(_ sender: AlertViewButton) {
		switch sender.type {
		case .cancel:
			didSelected?(.cancel, -1, cancelButtonTitle ?? "")
		case .confirm:
			didSelected?(.confirm, sender.tag, otherButtonTitles[sender.tag])
		}
	}
	
}

class AlertViewButton: UIButton {
	
	enum AlertViewButtonType {
		case cancel
		case confirm
	}
	
	var type: AlertViewButtonType = .confirm
	
	convenience init(title: String, type: AlertViewButtonType) {
		self.init(frame: .zero)
		titleLabel?.font = UIFont.systemFont(ofSize: 15)
		setTitle(title, for: .normal)
		switch type {
		case .cancel:
			setTitleColor(UIColor.black, for: .normal)
			
		case .confirm:
			setTitleColor(UIColor.blue, for: .normal)
		}
		
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
