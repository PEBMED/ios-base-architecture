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
        UITabBar.appearance().tintColor = UIColor(named: "tabBarActive")
        setViewControllers(viewControllers, animated: false)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
