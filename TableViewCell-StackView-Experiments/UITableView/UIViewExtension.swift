//
//  UIViewExtension.swift
//
//  Created by Paige Sun on 2017-01-17.
//  Copyright © 2017 Paige Sun. All rights reserved.
//

import UIKit

public extension UIView {
    func addSubviewsForAutolayout(_ views: UIView...) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
    func constrainToFillView(_ otherView: UIView, respectingLayoutMargins: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraintsToFillView(otherView, respectingLayoutMargins: respectingLayoutMargins))
    }
    
    func constrainToFillViewVertically(_ otherView: UIView, respectingLayoutMargins: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraintsToFillViewVertically(otherView, respectingLayoutMargins: respectingLayoutMargins))
    }
    
    func constrainToFillViewHorizontally(_ otherView: UIView, respectingLayoutMargins: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraintsToFillViewHorizontally(otherView, respectingLayoutMargins: respectingLayoutMargins))
    }

    
    func constraintsToFillView(_ otherView: UIView, respectingLayoutMargins: Bool = false) -> [NSLayoutConstraint] {
        return constraintsToFillViewHorizontally(otherView, respectingLayoutMargins: respectingLayoutMargins) + constraintsToFillViewVertically(otherView, respectingLayoutMargins: respectingLayoutMargins)
    }
    
    func constraintsToFillViewVertically(_ otherView: UIView, respectingLayoutMargins: Bool = false) -> [NSLayoutConstraint] {
        if respectingLayoutMargins {
            let layoutMarginsGuide = otherView.layoutMarginsGuide
            
            return [
                topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
            ]
        } else {
            return [
                topAnchor.constraint(equalTo: otherView.topAnchor),
                bottomAnchor.constraint(equalTo: otherView.bottomAnchor)
            ]
        }
    }
    
    func constraintsToFillViewHorizontally(_ otherView: UIView, respectingLayoutMargins: Bool = false) -> [NSLayoutConstraint] {
        if respectingLayoutMargins {
            let layoutMarginsGuide = otherView.layoutMarginsGuide
            
            return [
                leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
            ]
        } else {
            return [
                leadingAnchor.constraint(equalTo: otherView.leadingAnchor),
                trailingAnchor.constraint(equalTo: otherView.trailingAnchor)
            ]
        }
    }

}
