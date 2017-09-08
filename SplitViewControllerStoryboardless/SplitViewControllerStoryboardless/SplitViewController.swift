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
        let detailNavigationController = (detail123ViewController ?? masterNavigationController.topViewController) as? UINavigationController
        
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
    
    override func showNewDetailViewControllerNoNavigationController(_ vc: UIViewController, sender: UIViewController?) {
        guard let masterNavigationController = masterViewController as? UINavigationController else {
            // Should never happen,
            showDetailViewController(vc, sender: sender)
            return
        }
        
        // Check whether the sender is the master view
        let masterSender: Bool = masterViewController == sender || masterNavigationController.topViewController == sender
        
        // If we're collapsed, then the topViewController of the masterNavigationController *can* be the detail navigation controller (but only if details are being shown)
        let detailNavigationController = (detail123ViewController ?? masterNavigationController.topViewController) as? UINavigationController
        
        if detailNavigationController != nil {
            if masterSender {
                viewControllers.popLast()
                showDetailViewController(vc, sender: sender)
            } else {
                if isCollapsed {
                    var current = masterNavigationController.viewControllers
                    current.removeLast()
                    masterNavigationController.viewControllers = current + [vc]
                } else {
                    viewControllers = [masterNavigationController] + [vc]
                }
            }
        } else {
            showDetailViewController(vc, sender: sender)
        }
    }
    
}

extension UISplitViewController {
    var masterViewController: UIViewController? {
        return viewControllers.first
    }
    
    // rename to detailNavigationController?
    var detail123ViewController: UIViewController? { // can't call this "detailViewController" b/c it overrides one of Apple's variable name.
//        return viewControllers.count > 1 ? viewControllers.last : nil
        
        if viewControllers.count > 1 {
            return viewControllers.last
        } else if let masterNavigationController = masterViewController as? UINavigationController, isCollapsed, masterNavigationController.viewControllers.count > 1 {
            // The masterNavigationController's topViewController *can* be the detail navigation controller
            // If there is ONLY MASTER: this will give masterNavigationController.
            // If there is BOTH MASTER & DETAIL, this will give detailNavigationController
            
            return masterNavigationController.topViewController
        }
        return nil

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
    
    func showNewDetailViewControllerNoNavigationController(_ vc: UIViewController, sender: UIViewController?) {
        if let splitController = splitViewController as? SplitViewController {
            splitController.showNewDetailViewControllerNoNavigationController(vc, sender: sender)
        }
    }

}
