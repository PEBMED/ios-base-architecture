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
    var hasMoreFollowers = true

    func fetchRepositoriesData(completion: @escaping (SearchRepositories?, String?, Bool) -> Void) {
        let stringURL = "search/repositories?q=topic:javascript&per_page=20&page=\(page)"
        NetworkManager.shared.fetchData(stringURL: stringURL, type: SearchRepositories.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repositories):
                completion(repositories, nil, self.checkAndUpdatePage(repositories))
            case .failure(let error):
                completion(nil, error.rawValue, false)
            }
        }
    }

    func checkAndUpdatePage(_ repositories: SearchRepositories) -> Bool {
        page += 1
        return repositories.items.count == 20
    }
}
