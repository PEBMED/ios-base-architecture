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
    private let factory: FavoritesFactory

    // MARK: - Init
    init(navigationController: UINavigationController, factory: FavoritesFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    // MARK: - Coordinator
    func start() {
        let controller = factory.makeFavoritesViewController(coordinator: self)

        navigationController.viewControllers = [controller]
    }

    // MARK: - Deinit
    deinit {
        print("DEINIT -FavoritesCoordinator")
    }
}

// MARK: - FavoritesCoordinatorProtocol
extension FavoritesCoordinator: FavoritesCoordinatorProtocol {}
