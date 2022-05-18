//
//  BaseNavigationController.swift
//  Assesment 2022
//
//  Created by RenhardJH on 26/04/22.
//

import UIKit

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableSwipeBack()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func enableSwipeBack() {
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true
        navigationItem.backBarButtonItem?.isEnabled = true
    }
}
