//
//  CustomPresentationController
//  SunshineBrowser
//
//  Created by ChenGuangchuan on 2017/11/14.
//  Copyright © 2017年 cgc. All rights reserved.
//

import Foundation
import UIKit

class CustomPresentationController: UIPresentationController {

	lazy var dimmingView: UIView = { [unowned self] in
        let dimmingView = UIView()
        dimmingView.backgroundColor = .black
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmingView(_:))))
        return dimmingView
    }()
	
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.addSubview(dimmingView)
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coordinatorContex) in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (coodinatorContex) in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView else { return }
        dimmingView.frame = containerView.bounds
    }
    
    @objc private func didTapDimmingView(_ sender: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}

