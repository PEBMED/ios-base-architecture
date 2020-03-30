//
//  PullRequestListCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol PullRequestListCoordinatorProtocol: AnyObject {
    func goToDetail(viewModelItem: PullRequestViewModelItem, ownerName: String, repoName: String)
}

final class PullRequestListCoordinator: Coordinator {
    // MARK: - Typealias
    typealias Factory = PullRequestListFactory & PullRequestDetailFactory & UserDetailFactory
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let factory: Factory
    private let viewModelItem: RepositoryViewModelItem

    // MARK: - Init
    init(navigationController: UINavigationController, factory: Factory, viewModelItem: RepositoryViewModelItem) {
        self.navigationController = navigationController
        self.factory = factory
        self.viewModelItem = viewModelItem
    }

    // MARK: - Coordinator
    func start() {
        let controller = factory.makePullRequestListViewController(coordinator: self, viewModelItem: viewModelItem)
        navigationController.pushViewController(controller, animated: true)
    }

    // MARK: - Deinit
    deinit {
        print("DEINIT -PullRequestListCoordinator")
    }
}

// MARK: - PullRequestListCoordinatorProtocol
extension PullRequestListCoordinator: PullRequestListCoordinatorProtocol {
    func goToDetail(viewModelItem: PullRequestViewModelItem, ownerName: String, repoName: String) {
        let coordinator = PullRequestDetailCoordinator(navigationController: navigationController,
                                                       factory: factory,
                                                       viewModelItem: viewModelItem,
                                                       ownerName: ownerName,
                                                       repoName: repoName)
        coordinator.start()
    }
}
