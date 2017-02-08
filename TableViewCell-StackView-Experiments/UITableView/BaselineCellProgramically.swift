//
//  BaselineCellProgramically.swift
//  UITableView
//
//  Created by Paige Sun on 2017-02-07.
//  Copyright © 2017 Paige Sun. All rights reserved.
//

import UIKit

class BaselineCellProgramically: UITableViewCell {
    
    let stackView = UIStackView()
    let leftIcon = UIImageView(image: UIImage(named: "mountain.png"))
    let titleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
        setupStackView()
        setupLeftIcon()
        setupTitleLabel()
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
        stackView.distribution = .fill
        contentView.addSubviewsForAutolayout(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
    }
    
    private func setupLeftIcon() {
        stackView.addArrangedSubview(leftIcon)
        
        NSLayoutConstraint.activate([
            leftIcon.widthAnchor.constraint(equalToConstant: 30),
            leftIcon.heightAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    private func setupTitleLabel() {
        
        titleLabel.text = "This cell is programically created. This cell is programically created.  This cell is programically created.  This cell is programically created."
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .green
        stackView.addArrangedSubview(titleLabel)

        let firstBaseline = titleLabel.firstBaselineAnchor.constraint(equalTo: leftIcon.bottomAnchor)
        firstBaseline.priority = 999
        firstBaseline.isActive = true

    }
    
}
