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
        label.text = "This ia programically created yellow label, nested inside a blue UIView with layout margins."
        view.addSubview(label)
        
        view.layoutMargins = UIEdgeInsetsMake(10, 10, 10, 10)
        label.constrainToFillView(view, respectingLayoutMargins: true) // uses the layout margins
    }
}
