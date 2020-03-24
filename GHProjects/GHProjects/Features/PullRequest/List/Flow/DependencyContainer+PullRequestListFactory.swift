//
//  DependencyContainer+PullRequestListFactory.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

extension DependencyContainer: PullRequestListFactory {
    func makePullRequestListViewController(coordinator: PullRequestListCoordinatorProtocol,
                                           viewModelItem: RepositoryViewModelItem) -> PullRequestListViewController {
        let service = DefaultPullRequestService()
        let defaultPullRequestViewModel = DefaultPullRequestViewModel(ownerName: viewModelItem.login,
                                                                      repoName: viewModelItem.name,
                                                                      service: service)
        return PullRequestListViewController(coordinator: coordinator, viewModel: defaultPullRequestViewModel)
    }
}
