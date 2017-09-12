//
//  ListViewController.swift
//  SplitViewControllerStoryboardless
//
//  Created by Pei Sun on 2017-09-03.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation
import UIKit

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
    var cellStates: [CellState] = []
    
    private let cellReuseIdentifer = "DefaultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 88
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifer)
    }

    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellStates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifer)!
        cell.backgroundColor = cellStates[indexPath.row].backgroundColor
        cell.textLabel?.text = cellStates[indexPath.row].text
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    // MARK: - Cell Selection
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cellStates[indexPath.row].onCellSelection()
    }    
}
