//
//  DefaultPullRequestDetailsService.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

final class DefaultPullRequestDetailsService: PullRequestDetailsService {
    func fetchPullRequestDetailsData(_ owner: String,
                                     repository: String,
                                     id: Int,
                                     completion: @escaping (PullRequestDetail?, String?) -> Void) {
        NetworkManager.shared.fetchData(stringURL: "repos/\(owner)/\(repository)/pulls/\(id)", type: PullRequestDetail.self) { result in
            switch result {
            case .success(let pullRequestDetail):
                completion(pullRequestDetail, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            }
        }
    }
}
