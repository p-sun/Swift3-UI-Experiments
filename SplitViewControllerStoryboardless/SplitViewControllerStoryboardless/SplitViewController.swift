//
//  SplitViewController.swift
//  SplitViewControllerStoryboardless
//
//  Created by Pei Sun on 2017-09-04.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation
import UIKit

class SplitViewController: UISplitViewController {
    /// Shows a new view controller in the UISplitViewController's detail view's navigation stack.
    /// If the sender is in the master view, replace the detail stack.
    /// If the sender is in the detail view, append to the detail stack.
    override func showNewDetailViewController(_ vc: UIViewController, sender: UIViewController?) {
        guard let masterNavigationController = masterViewController as? UINavigationController else {
            // Should never happen,
            showDetailViewController(vc, sender: sender)
            return
        }
        
        // Check whether the sender is the master view
        let masterSender: Bool = masterViewController == sender || masterNavigationController.topViewController == sender
        
        // If we're collapsed, then the topViewController of the masterNavigationController *can* be the detail navigation controller (but only if details are being shown)
        let detailNavigationController = (detailViewController ?? masterNavigationController.topViewController) as? UINavigationController
        
        if let detailNavigationController = detailNavigationController {
            if masterSender {
                // Replace the detail stack if the sender is the master view
                detailNavigationController.setViewControllers([vc], animated: false)
            } else {
                detailNavigationController.show(vc, sender: sender)
            }
        } else {
            // If there's no detail nav controller we always create one. It will get collapsed into the master view controller if we're in collapsed mode
            showDetailViewController(UINavigationController(rootViewController: vc), sender: sender)
        }
    }
}

extension UISplitViewController {
    var masterViewController: UIViewController? {
        return viewControllers.first
    }
    
    var detailViewController: UIViewController? {
        return viewControllers.count > 1 ? viewControllers.last : nil
    }
}

class MasterNavigationController: UINavigationController {
    override func separateSecondaryViewController(for splitViewController: UISplitViewController) -> UIViewController? {
        
        print("************************")
        print("self:")
        print(viewControllers)
        let bottomNavController = viewControllers.last as? UINavigationController
        print("bottom nav controller's stack:")
        print(bottomNavController?.viewControllers)
        
        // By default this method pops and returns the view controller on the top of its navigation stack.
        // 
        if viewControllers.count > 1
            && viewControllers.last is UINavigationController
            || viewControllers.last is DetailRootViewController {

            return viewControllers.popLast()
        } else {
            return nil
        }
    }
}


extension UIViewController {
    func showNewDetailViewController(_ vc: UIViewController, sender: UIViewController?) {
        if let splitController = splitViewController as? SplitViewController {
            splitController.showNewDetailViewController(vc, sender: sender)
        }
    }
}
