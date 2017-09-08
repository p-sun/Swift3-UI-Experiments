//
//  ListViewController.swift
//  SplitViewControllerStoryboardless
//
//  Created by Pei Sun on 2017-09-03.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation
import UIKit

private extension UIViewController {
    var isMasterViewController: Bool {
        return self == (self.splitViewController?.masterViewController as? UINavigationController)?.topViewController
    }
    
    var navigationStackCount: Int {
        if isMasterViewController {
            return (splitViewController?.masterViewController as? UINavigationController)?.viewControllers.count ?? 0
        } else {
            return (splitViewController?.detail123ViewController as? UINavigationController)?.viewControllers.count
                ?? 0
        }
    }
}

struct CellState {
    let text: String
    let backgroundColor: UIColor?
    let onCellSelection: (() -> ())
    
    init(text: String, backgroundColor: UIColor? = nil, onCellSelection: @escaping (() -> ())) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.onCellSelection = onCellSelection
    }
}

class ListViewController: UITableViewController {
    var menuItems: [CellState] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = isMasterViewController ? "Master View Controller" : "Detail View Controller"
        
        tableView.estimatedRowHeight = 88
        
        setMenuItems()
    }

    // MARK: - UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = menuItems[indexPath.row].text
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = menuItems[indexPath.row].backgroundColor
        
        return cell
    }
    
    // MARK: - Segue
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        menuItems[indexPath.row].onCellSelection()
    }
    
    // MARK: - Set Menu
    
    private func setMenuItems() {
        let stackCount = "This stack has \(navigationStackCount) controller(s)."
        let instanceIdentifier = description.substring(between: Character(" "), until: Character(">")) ?? ""
        let instanceInfo = "Current is \(instanceIdentifier)."
        menuItems.append(
            CellState(
                text: stackCount + "\n" + instanceInfo,
                backgroundColor: UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0),
                onCellSelection: {}
            )
        )
        
        menuItems.append(
            CellState(
                text: "Show controller on current stack",
                onCellSelection: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.show(ListViewController(), sender: strongSelf)
            })
        )
        
        let menuLabel = isMasterViewController ? "Reset detail stack" : "Show controller on detail stack"
        menuItems.append(
            CellState(
                text: menuLabel,
                onCellSelection: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.showNewDetailViewController(ListViewController(), sender: strongSelf)
            })
        )
    }
}

private extension String {
    // Returns the String between two characters, excluding the delimiters.
    func substring(between start: Character, until end: Character) -> String? {
        guard contains(end.description) else { return nil }
        
        if let match = range(of: "(?<=\(start))[^\(end)]+", options: .regularExpression) {
            return substring(with: match)
        }
        return nil
    }
}
