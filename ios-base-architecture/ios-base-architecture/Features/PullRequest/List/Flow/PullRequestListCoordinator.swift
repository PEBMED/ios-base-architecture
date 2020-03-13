//
//  PullRequestListCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol PullRequestListCoordinatorProtocol: AnyObject {}

final class PullRequestListCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let factory: PullRequestListFactory
    private let viewModelItem: RepositoryViewModelItem

    // MARK: - Init
    init(navigationController: UINavigationController, factory: PullRequestListFactory, viewModelItem: RepositoryViewModelItem) {
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
extension PullRequestListCoordinator: PullRequestListCoordinatorProtocol {}
