//
//  AppDelegate.swift
//  SplitViewControllerStoryboardless
//
//  Created by Pei Sun on 2017-09-02.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let listViewController = ListViewController()
        let master = MasterNavigationController(rootViewController: listViewController)
        let detail = DetailRootViewController("Root Details Controller")
        let splitViewController = SplitViewController()
        splitViewController.viewControllers = [master, detail]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()

        return true
    }
}
