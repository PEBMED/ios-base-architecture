//
//  PullRequestViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol PullRequestViewModel {
    var ownerName: String { get }
    var repoName: String { get }
    var hasMoreData: Bool { get set }

    init(ownerName: String, repoName: String, service: PullRequestService)

    func fetchPullRequests(completion: @escaping (Bool, String?) -> Void)
    func getPullRequestViewModelItem(with indexPath: IndexPath) -> PullRequestViewModelItem
    func getPullRequestViewModelNumberOfItems() -> Int
}
