//
//  GHTabBarController.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout(){
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.6745098039, blue: 0.9294117647, alpha: 1)
         viewControllers = [setupRepositoriesController(), setupFavoritesController()]
    }
    
    func setupRepositoriesController()->UIViewController{
        let repositoriesCollectionViewController = RepositoriesCollectionViewController(viewModel: DefaultRepositoryViewModel(service: DefaultRepositoryService()))
        
        repositoriesCollectionViewController.title = "Repositories"
        repositoriesCollectionViewController.tabBarItem.image = SFSymbols.folder
        
        return GHCustomNavigationController(rootViewController: repositoriesCollectionViewController)
    }
    
    func setupFavoritesController()->UIViewController{
        let favoritesViewController = UIViewController()
        favoritesViewController.view.backgroundColor = .white
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem.image = SFSymbols.star
        
        return GHCustomNavigationController(rootViewController: favoritesViewController)
    }
}
