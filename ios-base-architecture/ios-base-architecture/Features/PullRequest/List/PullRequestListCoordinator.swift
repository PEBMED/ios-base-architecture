//
//  PullRequestListCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol PullRequestListCoordinatorProtocol: AnyObject {
    func goToDetail()
}

final class PullRequestListCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let repository: RepositoryViewModelItem

    // MARK: - Init
    init(navigationController: UINavigationController, repository: RepositoryViewModelItem) {
        self.navigationController = navigationController
        self.repository = repository
    }

    // MARK: - Coordinator
    func start() {
        let service = DefaultPullRequestService()
        let defaultPullRequestViewModel = DefaultPullRequestViewModel(ownerName: repository.login,
                                                                      repoName: repository.name,
                                                                      service: service)
        let controller = PullRequestCollectionViewController(coordinator: self, viewModel: defaultPullRequestViewModel)

        navigationController.pushViewController(controller, animated: true)
    }

    // MARK: - Deinit
    deinit {
        print("DEINIT -PullRequestListCoordinator")
    }
}

// MARK: - PullRequestListCoordinatorProtocol
extension PullRequestListCoordinator: PullRequestListCoordinatorProtocol {
    func goToDetail() {}
}
