//
//  DependencyContainer+PullRequestDetailFactory.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

extension DependencyContainer: PullRequestDetailFactory {
    func makePullRequestDetailViewController(coordinator: PullRequestDetailCoordinatorProtocol,
                                             viewModelItem: PullRequestViewModelItem,
                                             ownerName: String,
                                             repoName: String) -> PullRequestDetailViewController {
        let service = DefaultPullRequestDetailsService()
        let pullRequestDetailViewModel = DefautPullRequestDetailsViewModel(login: ownerName,
                                                                           repoName: repoName,
                                                                           pullRequestNumber: viewModelItem.number,
                                                                           service: service)

        return PullRequestDetailViewController(coordinator: coordinator, viewModel: pullRequestDetailViewModel)
    }
}
