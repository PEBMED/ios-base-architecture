//
//  TabbarCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class TabbarCoordinator: Coordinator {
    // MARK: - Typealias
    typealias Factory = RepositoryFactory & PullRequestListFactory & PullRequestDetailFactory & FavoritesFactory & UserDetailFactory

    // MARK: - Properties
    private let window: UIWindow
    private let factory: Factory

    // MARK: - Init
    init(window: UIWindow, factory: Factory) {
        self.window = window
        self.factory = factory
    }

    // MARK: - Coordinator
    func start() {
        var navigationControllers = [UINavigationController]()

        // Repositories
        let repositoriesNavigationController = GHCustomNavigationController()
        let repositoriesCoordinator = RepositoriesListCoordinator(navigationController: repositoriesNavigationController, factory: factory)
        repositoriesCoordinator.start()
        navigationControllers.append(repositoriesNavigationController)

        // Favorites
        let favoritesNavigationController = GHCustomNavigationController()
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController, factory: factory)
        favoritesCoordinator.start()
        navigationControllers.append(favoritesNavigationController)

        window.rootViewController = GHTabBarController(viewControllers: navigationControllers)
    }

    // MARK: - Deinit
    deinit {
        debugPrint("DEINIT -TabBarCoordinator")
    }
}
