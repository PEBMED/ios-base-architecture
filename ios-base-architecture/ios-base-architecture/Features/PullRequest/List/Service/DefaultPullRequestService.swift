//
//  DefaultPullRequestService.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

final class DefaultPullRequestService: PullRequestService {
    private var page = 1

    func fetchPullRequestData(_ owner: String, repository: String, completion: @escaping ([PullRequest]?, String?, Bool) -> Void) {
        NetworkManager.shared.fetchData(stringURL: "repos/\(owner)/\(repository)/pulls?per_page=20&page=\(page)", type: [PullRequest].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pullRequests):
                completion(pullRequests, nil, self.checkAndUpdatePage(pullRequests))
            case .failure(let error):
                completion(nil, error.rawValue, false)
            }
        }
    }

    func checkAndUpdatePage(_ pullRequests: [PullRequest]) -> Bool {
        page += 1
        return pullRequests.count == 20
    }
}
