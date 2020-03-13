//
//  TabbarCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class TabbarCoordinator: Coordinator {
    // MARK: - Properties
    private let window: UIWindow

    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Coordinator
    func start() {
        var navigationControllers = [UINavigationController]()

        // Repositories
        let repositoriesNavigationController = GHCustomNavigationController()
        let repositoriesCoordinator = RepositoriesListCoordinator(navigationController: repositoriesNavigationController)
        repositoriesCoordinator.start()
        navigationControllers.append(repositoriesNavigationController)

        // Favorites
        let favoritesNavigationController = GHCustomNavigationController()
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController)
        favoritesCoordinator.start()
        navigationControllers.append(favoritesNavigationController)

        window.rootViewController = GHTabBarController(viewControllers: navigationControllers)
    }

    // MARK: - Deinit
    deinit {
        debugPrint("DEINIT -TabBarCoordinator")
    }
}
