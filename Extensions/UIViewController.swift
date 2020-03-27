//
//  UIViewController.swift
//  carpino-passenger-ios-swift
//
//  Created by negar on 98/Azar/04 AP.
//  Copyright © 1398 carpino corp. All rights reserved.
//

import UIKit

extension UIViewController {

    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiateFromStoryboardName(storyboardName: StoryboardName) -> Self {
        return storyboardName.viewController(viewControllerClass: self)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
