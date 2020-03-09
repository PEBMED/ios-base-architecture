//
//  CustomNavigationController.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHCustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    func setupLayout() {
        navigationBar.barTintColor = .systemBackground
        navigationBar.tintColor = .systemBlue
        navigationBar.prefersLargeTitles = true
    }
}
