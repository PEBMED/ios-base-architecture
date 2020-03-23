//
//  FakeRespositoryService.swift
//  GHProjectsUITests
//
//  Created by Jonathan Bijos on 23/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects

final class FakeRespositoryService: FakeService, RepositoryService {
    lazy var searchRepositories: SearchRepositories = SearchRepositories(items: [])
    var hasNext: Bool = false
    var error: GHError = .invalidResponse

    func fetchRepositoriesData(completion: @escaping (Result<SearchRepositories, GHError>, Bool) -> Void) {
        switch responseType {
        case .sucess:
            completion(.success(searchRepositories), hasNext)
        case .failure:
            completion(.failure(error), hasNext)
        }
    }
}
