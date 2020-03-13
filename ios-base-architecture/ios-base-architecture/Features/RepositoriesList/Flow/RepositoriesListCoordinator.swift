//
//  RepositoriesListCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol RepositoriesListCoordinatorProtocol: AnyObject {
    func goToPullRequestList(viewModelItem: RepositoryViewModelItem)
}

final class RepositoriesListCoordinator: Coordinator {
    // MARK: - Typealias
    typealias Factory = RepositoryFactory & PullRequestListFactory
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let factory: Factory

    // MARK: - Init
    init(navigationController: UINavigationController, factory: Factory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    // MARK: - Coordinator
    func start() {
        let controller = factory.makeRepositoriesListViewController(coordinator: self)
        navigationController.viewControllers = [controller]
    }

    // MARK: - Deinit
    deinit {
        print("DEINIT -RepositoriesListCoordinator")
    }
}

// MARK: - RepositoriesListCoordinatorProtocol
extension RepositoriesListCoordinator: RepositoriesListCoordinatorProtocol {
    func goToPullRequestList(viewModelItem: RepositoryViewModelItem) {
        let coordinator = PullRequestListCoordinator(navigationController: navigationController,
                                                     factory: factory,
                                                     viewModelItem: viewModelItem)
        coordinator.start()
    }
}
