//
//  PullRequestService.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol PullRequestService {
    func fetchPullRequestData(_ owner: String, repository: String, completion: @escaping (Result<[PullRequest], GHError>, Bool) -> Void)
}
