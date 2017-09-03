//
//  RightSplitDetailController.swift
//  SplitViewControllerExperiment
//
//  Created by Pei Sun on 2017-08-31.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import Foundation
import UIKit

class RightSplitDetailController: UIViewController {
    @IBOutlet weak var detailLabel: UILabel!
    
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.text = text
    }    
}
