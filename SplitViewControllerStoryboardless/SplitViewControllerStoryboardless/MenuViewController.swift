//
//  MenuViewController.swift
//  SplitViewControllerStoryboardlessSimple
//
//  Created by Pei Sun on 2017-09-09.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: ListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = isMasterController ? "Master Controller" : "Detail Controller"
        setCellStates()
    }
    
    private func setCellStates() {
        let stackCount = "This stack has \(navigationStackCount) controller(s)."
        let instanceIdentifier = description.substring(between: Character(" "), until: Character(">")) ?? ""
        let instanceInfo = "Current is \(instanceIdentifier)."
        let randomColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        cellStates.append(
            CellState(
                text: stackCount + "\n" + instanceInfo,
                backgroundColor: randomColor,
                onCellSelection: {}
            )
        )
        
        cellStates.append(
            CellState(
                text: "Show controller on current stack\n\t" + ".show(MenuViewController())",
                onCellSelection: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.show(MenuViewController(), sender: strongSelf)
            })
        )
        
        let menuLabel = isMasterController ?
            "Reset detail stack\n\t" + ".showOnDetailController(MenuViewController())":
            "Show controller on detail stack\n\t" + ".showOnDetailController(MenuViewController())"
        cellStates.append(
            CellState(
                text: menuLabel,
                onCellSelection: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.showOnDetailController(MenuViewController(), sender: strongSelf)
            })
        )
    }
}

private extension UIViewController {
    var isMasterController: Bool {
        let masterNavigationController = splitViewController?.masterController as? UINavigationController
        return self == masterNavigationController?.topViewController
    }
    
    var navigationStackCount: Int {
        let currentSplitController = isMasterController ?
            splitViewController?.masterController :
            splitViewController?.detailController
        let currentSplitNavigationController = currentSplitController as? UINavigationController
        return currentSplitNavigationController?.viewControllers.count ?? 0
    }
}
