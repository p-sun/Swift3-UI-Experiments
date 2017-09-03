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
        listViewController.title = "Split View Controller Demo"
        let masterController = UINavigationController(rootViewController: listViewController)
        
        let detailController = DetailViewController("Root Detail Controller")

        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [masterController, detailController]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()

        return true
    }
}
