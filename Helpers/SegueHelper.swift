//
//  SegueHelper.swift
//  carpino-passenger-ios-swift
//
//  Created by negar on 98/Azar/04 AP.
//  Copyright © 1398 carpino corp. All rights reserved.
//


import UIKit

enum StoryboardName: String {
//    case Main, UserActions,  //Create StoryBoard Names Here
    
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
            return self.instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

class SegueHelper: NSObject {
    
    class func pushViewController(sourceViewController: UIViewController, destinationViewController: UIViewController) {
        sourceViewController.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    class func pushViewControllerWithoutAnimation(sourceViewController: UIViewController, destinationViewController: UIViewController) {
        sourceViewController.navigationController?.pushViewController(destinationViewController, animated: false)
    }
    
    class func presentViewController(sourceViewController: UIViewController, destinationViewController: UIViewController) {
        sourceViewController.present(destinationViewController, animated: true, completion: nil)
    }

    class func popViewController(viewController: UIViewController){
        viewController.navigationController?.popViewController(animated: true)
    }
    
}
