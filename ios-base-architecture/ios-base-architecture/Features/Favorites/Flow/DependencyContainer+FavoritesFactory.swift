//
//  DependencyContainer+FavoritesFactory.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//
import UIKit

extension DependencyContainer: FavoritesFactory {
    func makeFavoritesViewController(coordinator: FavoritesCoordinatorProtocol) -> FavoritesViewController {
        let controller = FavoritesViewController()
        controller.view.backgroundColor = UIColor(named: "favoritesBackground")
        controller.title = "Favorites"
        controller.tabBarItem.image = SFSymbols.star
        return controller
    }
}
