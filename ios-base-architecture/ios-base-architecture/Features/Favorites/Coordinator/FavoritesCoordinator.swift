//
//  FavoritesCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol FavoritesCoordinatorProtocol: AnyObject {}

final class FavoritesCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController

    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator
    func start() {
        let controller = FavoritesViewController()
        controller.title = "Favorites"
        controller.tabBarItem.image = SFSymbols.star

        navigationController.viewControllers = [controller]
    }

    // MARK: - Deinit
    deinit {
        print("DEINIT -FavoritesCoordinator")
    }
}

// MARK: - FavoritesCoordinatorProtocol
extension FavoritesCoordinator: FavoritesCoordinatorProtocol {}
