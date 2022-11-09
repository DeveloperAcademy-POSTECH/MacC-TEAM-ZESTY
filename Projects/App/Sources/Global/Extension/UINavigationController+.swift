//
//  UIViewController+.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/23.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

// Swipe to pop
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.last is SwipeForbidden {
            return false
        }
        return viewControllers.count > 1
    }
}

protocol SwipeForbidden {}

extension PlaceListViewController: SwipeForbidden {}
extension DomainSettingViewController: SwipeForbidden {}
extension AddPlaceResultViewController: SwipeForbidden {}
extension ReviewCardViewController: SwipeForbidden {}
extension SignupCompleteViewController: SwipeForbidden {}
