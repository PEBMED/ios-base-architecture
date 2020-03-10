//
//  GHTabBarController.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class GHTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.6745098039, blue: 0.9294117647, alpha: 1)
        viewControllers = [setupRepositoriesController(), setupFavoritesController()]
    }

    func setupRepositoriesController() -> UIViewController {
        let service = DefaultRepositoryService()
        let viewModel = DefaultRepositoryViewModel(service: service)
        let repositoriesCollectionViewController = RepositoriesCollectionViewController(viewModel: viewModel)

        repositoriesCollectionViewController.title = "Repositories"
        repositoriesCollectionViewController.tabBarItem.image = SFSymbols.folder

        return GHCustomNavigationController(rootViewController: repositoriesCollectionViewController)
    }

    func setupFavoritesController() -> UIViewController {
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.view.backgroundColor = .white
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem.image = SFSymbols.star

        return GHCustomNavigationController(rootViewController: favoritesViewController)
    }
}
