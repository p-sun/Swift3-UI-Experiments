//
//  LeftSplitTableController.swift
//  SplitViewControllerExperiment
//
//  Created by Pei Sun on 2017-08-31.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation
import UIKit

class LeftSplitTableController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // By default on iPad, we get primaryOverlay in portrait and allVisible in landscape.
        // Uncomment to have both the left and right controllers on portrait on iPad.
        // splitViewController?.preferredDisplayMode = .allVisible
    }

    // MARK: UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    // MARK: Segue
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let index = self.tableView.indexPathForSelectedRow! as NSIndexPath
            let vc = segue.destination as! RightSplitDetailController
            
            vc.text = "Details of Row: " + String(index.row)
        }
    }
}
