//
//  DependencyContainer+FavoritesFactory.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

extension DependencyContainer: FavoritesFactory {
    func makeFavoritesViewController(coordinator: FavoritesCoordinatorProtocol) -> FavoritesViewController {
        let controller = FavoritesViewController()
        controller.title = "Favorites"
        controller.tabBarItem.image = SFSymbols.star
        controller.tabBarItem.accessibilityIdentifier = "favoritesTabBarItem"
        return controller
    }
}
