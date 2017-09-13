//
//  SingleLabelViewController.swift
//  SplitViewControllerStoryboardless
//
//  Created by Pei Sun on 2017-09-02.
//  Copyright © 2017 Pei Sun. All rights reserved.
//

import UIKit

/// A reusable green view controller with a single label centered in the middle.
class SingleLabelViewController: UIViewController {
    private var label = UILabel()
    let text: String
    
    required init(_ text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        view.addSubview(label)
        setupLabel()
    }
    
    private func setupLabel() {
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}
