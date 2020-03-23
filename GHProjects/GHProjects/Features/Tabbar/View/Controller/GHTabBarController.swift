//
//  GHTabBarController.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class GHTabBarController: UITabBarController {
    // MARK: - Init
    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.6745098039, blue: 0.9294117647, alpha: 1)
        setViewControllers(viewControllers, animated: false)
        view.accessibilityIdentifier = "ghTabBarControllerView"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
