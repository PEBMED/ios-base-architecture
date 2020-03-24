//
//  FakeRespositoryService.swift
//  GHProjectsUITests
//
//  Created by Jonathan Bijos on 23/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects

final class FakeRespositoryService: FakeService, RepositoryService {
    var searchRepositories: SearchRepositories!
    var hasNext: Bool!
    var error: GHError!

    func fetchRepositoriesData(completion: @escaping (Result<SearchRepositories, GHError>, Bool) -> Void) {
        switch responseType {
        case .sucess:
            completion(.success(searchRepositories), hasNext)
        case .failure:
            completion(.failure(error), hasNext)
        }
    }
}
