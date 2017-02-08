//
//  NestedViewsCell.swift
//  UITableView
//
//  Created by Paige Sun on 2017-02-07.
//  Copyright © 2017 Paige Sun. All rights reserved.
//

import UIKit

class NestedViewsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {
        
        let view = UIView()
        view.backgroundColor = .blue
        contentView.addSubview(view)
        view.constrainToFillView(contentView)
        
        let label = UILabel()
        label.backgroundColor = .yellow
        label.numberOfLines = 0
        label.text = "This ia programically created label, nested inside a UIView."
        view.addSubview(label)
        label.constrainToFillView(view)
    }
}
