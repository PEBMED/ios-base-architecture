//
//  PullRequestDetailCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol PullRequestDetailCoordinatorProtocol: AnyObject {}

final class PullRequestDetailCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationController: UINavigationController
    private let factory: PullRequestDetailFactory
    private let viewModelItem: PullRequestViewModelItem
    private let ownerName: String
    private let repoName: String

    // MARK: - Init
    init(navigationController: UINavigationController,
         factory: PullRequestDetailFactory,
         viewModelItem: PullRequestViewModelItem,
         ownerName: String,
         repoName: String) {
        self.navigationController = navigationController
        self.factory = factory
        self.viewModelItem = viewModelItem
        self.ownerName = ownerName
        self.repoName = repoName
    }

    // MARK: - Coordinator
    func start() {
        let controller = factory.makePullRequestDetailViewController(coordinator: self,
                                                                     viewModelItem: viewModelItem,
                                                                     ownerName: ownerName,
                                                                     repoName: repoName)

        navigationController.pushViewController(controller, animated: true)
    }

    // MARK: - Deinit
    deinit {
        print("DEINIT -PullRequestDetailCoordinator")
    }
}

// MARK: - PullRequestDetailCoordinatorProtocol
extension PullRequestDetailCoordinator: PullRequestDetailCoordinatorProtocol {}
