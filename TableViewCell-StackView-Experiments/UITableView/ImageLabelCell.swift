//
//  ImageLabelCell.swift
//  UITableView
//
//  Created by Paige Sun on 2017-02-27.
//  Copyright © 2017 Paige Sun. All rights reserved.
//

import UIKit

class ImageLabelCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        let errorView = ErrorView()
        errorView.errorText = "This is an error view with a small image of 10x10 on the side. It is also inset on all sides with contraints."
        
        contentView.addSubview(errorView)
        errorView.constrainToFillView(contentView)
    }
}

private final class ErrorView: UIView {
    private let label = UILabel()
    private var topStackConstraint: NSLayoutConstraint!
    private var imageConstraints: [NSLayoutConstraint]!
    
    var errorText: String = "" {
        didSet {
            label.text = errorText
            topStackConstraint.constant = errorText == "" ? 0 : 16
            //			for constraint in imageConstraints {
            //				constraint.isActive = errorText != ""
            //			}
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let warningImage = UIImageView(image: UIImage(named: "mountain"))
        imageConstraints = [
            warningImage.heightAnchor.constraint(equalToConstant: 20),
            warningImage.widthAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(imageConstraints)
        
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.backgroundColor = .blue
        
        let contentBackground = UIView()
        contentBackground.backgroundColor = .purple
        addSubviewsForAutolayout(contentBackground)
        
        let contentStack = UIStackView(axis: .horizontal, alignment: .top, spacing: 4)
        contentStack.addArrangedSubviews(warningImage, label)
        
        addSubviewsForAutolayout(contentStack)
        topStackConstraint = contentStack.topAnchor.constraint(equalTo: self.topAnchor)
        NSLayoutConstraint.activate([
            topStackConstraint,
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
            ])
        
        contentStack.constrainToFillView(contentBackground) // put this back later. it's fine
        
        //		self.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    
    public convenience init(axis: UILayoutConstraintAxis, distribution: UIStackViewDistribution = .fill, alignment: UIStackViewAlignment = .fill, spacing: CGFloat = 0) {
        self.init()
        self.distribution = distribution
        self.alignment = alignment
        self.axis = axis
        self.spacing = spacing
    }
    
    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
