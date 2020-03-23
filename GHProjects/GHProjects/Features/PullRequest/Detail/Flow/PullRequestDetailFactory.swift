//
//  PullRequestDetailFactory.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

protocol PullRequestDetailFactory {
    func makePullRequestDetailViewController(coordinator: PullRequestDetailCoordinatorProtocol,
                                             viewModelItem: PullRequestViewModelItem,
                                             ownerName: String,
                                             repoName: String) -> PullRequestDetailViewController
}
