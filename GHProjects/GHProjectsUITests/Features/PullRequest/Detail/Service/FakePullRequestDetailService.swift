//
//  FakePullRequestDetailService.swift
//  GHProjectsUITests
//
//  Created by Jonathan Bijos on 24/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects

final class FakePullRequestDetailService: FakeService, PullRequestDetailsService {
    var pullRequestDetail: PullRequestDetail!
    var error: GHError!

    func fetchPullRequestDetailsData(
        _ owner: String,
        repository: String,
        id: Int,
        completion: @escaping (Result<PullRequestDetail, GHError>) -> Void) {
        switch responseType {
        case .sucess:
            completion(.success(pullRequestDetail))
        case .failure:
            completion(.failure(error))
        }
    }
}
