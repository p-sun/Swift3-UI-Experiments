//
//  SplitViewController.swift
//  SplitViewControllerStoryboardless
//
//  Created by Pei Sun on 2017-09-04.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation
import UIKit

// MARK: Show view controller on detail controller

class SplitViewController: UISplitViewController {
    /// Shows a new view controller in the split view controller's detail navigation controller.
    override func showOnDetailController(_ vc: UIViewController, sender: UIViewController?) {
        guard masterController as? UINavigationController != nil else {
            // Should not happen. If there's no master navigation controller, attempting to display a detail navigation controller will crash.
            showDetailViewController(vc, sender: sender)
            return
        }
        
        if let detailNavigationController = detailController as? UINavigationController {
            let isSenderFromMaster = masterController == sender
                || sender?.isInMasterController == true

            if isSenderFromMaster {
                // Replace the detail navigation stack.
                detailNavigationController.setViewControllers([vc], animated: false)
            } else {
                // Append to the detail navigation stack.
                detailNavigationController.show(vc, sender: sender)
            }
        } else {
            // If there's no detail navigation stack, create one.
            showDetailViewController(UINavigationController(rootViewController: vc), sender: sender)
        }
    }
}

extension UIViewController {
    var isInMasterController: Bool {
        let masterNavigationController = splitViewController?.masterController as? UINavigationController
        return self == masterNavigationController?.topViewController
    }
    
    func showOnDetailController(_ vc: UIViewController, sender: UIViewController?) {
        if let splitController = splitViewController as? SplitViewController {
            splitController.showOnDetailController(vc, sender: sender)
        }
    }
}

// MARK: Get master and detail controller

extension UISplitViewController {
    var masterController: UIViewController? {
        return viewControllers.first
    }
    
    var detailController: UIViewController? {
        if viewControllers.count > 1 {
            // Occurs when the split view controller *is not* collapsed, and both the master and detail view controllers exist.
            return viewControllers.last
        } else if let masterNavigationController = masterController as? UINavigationController, isCollapsed, masterNavigationController.viewControllers.count > 1 {
            // When the split view controller is collapsed, the detail controller will be masterNavigationController.topViewController.
            return masterNavigationController.topViewController
        } else {
            // Should not happen. There should always be a master controller and a detail controller.
            return nil
        }
    }
}

// MARK: Separate detail controller

class MasterNavigationController: UINavigationController {
    // When uncollapsing the MasterNavigationController (i.e. rotating from portrait to landscape on a phone), this method returns the detail controller.
    override func separateSecondaryViewController(for splitViewController: UISplitViewController) -> UIViewController? {
        
        // Detail controller is either UINavigationController or DetailSplitViewController.
        // If the the detail controller has been removed, return nil. i.e. when you tap back on the bottommost view controller in detail controller.
        guard viewControllers.count > 1
            && (viewControllers.last is UINavigationController || viewControllers.last is DetailSplitViewController) else {
                return nil
        }
        
        // By default, UINavigationController's separateSecondaryViewController pops and returns the top view controller.
        return viewControllers.popLast()
    }
}

/// All detail view controllers not wrapped in a UINavigationController should conform to this.
protocol DetailSplitViewController {}
