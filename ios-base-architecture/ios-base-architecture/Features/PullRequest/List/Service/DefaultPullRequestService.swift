//
//  DefaultPullRequestService.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

final class DefaultPullRequestService: PullRequestService {
    private var page: Int
    private let networkManager: DefaultNetworkManager

    init(page: Int = 1, networkManager: DefaultNetworkManager = DefaultNetworkManager()) {
        self.page = page
        self.networkManager = networkManager
    }

    func fetchPullRequestData(_ owner: String, repository: String, completion: @escaping (Result<[PullRequest], GHError>, Bool) -> Void) {
        let urlString = "repos/\(owner)/\(repository)/pulls?per_page=20&page=\(page)"

        networkManager.fetch(urlString: urlString, method: .get, parameters: [:], headers: [:]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                 do {
                    let decodedObject = try GHDecoder().decode([PullRequest].self, from: data)
                    completion(.success(decodedObject), self.checkAndUpdatePage(decodedObject))
                 } catch {
                    completion(.failure(GHError.invalidData), false)
                 }
            case .failure(let error):
                completion(.failure(error), false)
            }
        }
    }

    func checkAndUpdatePage(_ pullRequests: [PullRequest]) -> Bool {
        page += 1
        return pullRequests.count == 20
    }
}
