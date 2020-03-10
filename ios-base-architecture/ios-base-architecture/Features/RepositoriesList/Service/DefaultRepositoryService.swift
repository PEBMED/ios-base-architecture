//
//  RepositoryService.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class DefaultRepositoryService: RepositoryService {
    private var page = 1
    private let networkManager: NetworkManager

    var hasMoreFollowers = true

    init(page: Int = 1, networkManager: NetworkManager = DefaultNetworkManager()) {
        self.page = page
        self.networkManager = networkManager
    }

    func fetchRepositoriesData(completion: @escaping (Result<SearchRepositories, GHError>, Bool) -> Void) {
        let stringURL = "search/repositories?q=topic:javascript&per_page=20&page=\(page)"

        networkManager.fetch(urlString: stringURL, method: .get, parameters: [:], headers: [:]) { result in
            switch result {
            case .success(let data):
                 do {
                    let decodedObject = try GHDecoder().decode(SearchRepositories.self, from: data)
                    completion(.success(decodedObject), self.checkAndUpdatePage(decodedObject))
                 } catch {
                    completion(.failure(GHError.invalidData), false)
                 }
            case .failure(let error):
                completion(.failure(error), false)
            }
        }
    }

    func checkAndUpdatePage(_ repositories: SearchRepositories) -> Bool {
        page += 1
        return repositories.items.count == 20
    }
}
