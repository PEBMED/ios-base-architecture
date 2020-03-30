//
//  FakePullRequestService.swift
//  GHProjectsUITests
//
//  Created by Jonathan Bijos on 24/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects

final class FakePullRequestService: FakeService, PullRequestService {
    var pullRequest: [PullRequest]!
    var hasNext: Bool!
    var error: GHError!

    func fetchPullRequestData(_ owner: String, repository: String, completion: @escaping (Result<[PullRequest], GHError>, Bool) -> Void) {
        switch responseType {
        case .sucess:
            completion(.success(pullRequest), hasNext)
        case .failure:
            completion(.failure(error), hasNext)
        }
    }
}
