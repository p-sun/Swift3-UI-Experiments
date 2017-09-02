//
//  ViewController.swift
//  NavigationControllerTest
//
//  Created by Paige Sun on 2017-08-02.
//  Copyright © 2017 Shopify. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		extendedLayoutIncludesOpaqueBars = true

		let purpleView = UIView()
		purpleView.backgroundColor = UIColor.purple
		purpleView.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(purpleView)
		NSLayoutConstraint.activate([
			purpleView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
			purpleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			purpleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			purpleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

