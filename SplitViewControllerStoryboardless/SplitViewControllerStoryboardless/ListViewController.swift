//
//  ListViewController.swift
//  SplitViewControllerStoryboardless
//
//  Created by Pei Sun on 2017-09-03.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = isMasterViewController ? "Master View Controller" : "Detail View Controller"
    }

    // MARK: - UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cellText: String
        switch (isMasterViewController, indexPath.row) {
        case (_, 0):
            cellText = "Show controller on current stack"
        case (true, _):
            cellText = "Reset detail controller stack"
        case (false, _):
            cellText = "Show detail controller"
        }
        
        cell.textLabel?.text = cellText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Navigation Stack Count \(navigationStackCount)"
    }
    
    // MARK: - Segue
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let listController = ListViewController()
        if indexPath.row == 0 {
            show(listController, sender: self)
        } else {
            showNewDetailViewController(listController, sender: self)
        }
    }
}

private extension UIViewController {
    var isMasterViewController: Bool {
        return self == (self.splitViewController?.masterViewController as? UINavigationController)?.topViewController
    }
    
    var navigationStackCount: Int {
        if isMasterViewController {
            return (splitViewController?.masterViewController as? UINavigationController)?.viewControllers.count ?? 0
        } else {
            return (splitViewController?.detailViewController as? UINavigationController)?.viewControllers.count ?? 0
        }
    }
}
