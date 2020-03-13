//
//  RepositoriesListCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol RepositoriesListCoordinatorProtocol: AnyObject {
    func goToPullRequest(pullRequest: PullRequest)
}

final class RepositoriesListCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController

    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator
    func start() {
        let service = DefaultRepositoryService()
        let viewModel = DefaultRepositoryViewModel(service: service)
        let controller = RepositoriesCollectionViewController(viewModel: viewModel)
        controller.title = "Repositories"
        controller.tabBarItem.image = SFSymbols.folder

        navigationController.viewControllers = [controller]
    }

    // MARK: - Deinit
    deinit {
        print("DEINIT -RepositoriesListCoordinator")
    }
}

// MARK: - RepositoriesListCoordinatorProtocol
extension RepositoriesListCoordinator: RepositoriesListCoordinatorProtocol {
    func goToPullRequest(pullRequest: PullRequest) {}
}