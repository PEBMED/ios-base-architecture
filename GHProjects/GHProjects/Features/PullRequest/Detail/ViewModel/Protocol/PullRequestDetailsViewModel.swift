//
//  PullRequestDetailsViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol PullRequestDetailsViewModel {
    init(login: String, repoName: String, pullRequestNumber: Int, service: PullRequestDetailsService)
    func fetchPullRequests(completion: @escaping (Bool, String?) -> Void)
    func getPullRequestDetailViewModelItem() -> PullRequestDetailViewModelItem?
}
