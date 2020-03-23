//
//  DefaultPullRequestDetailsService.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

final class DefaultPullRequestDetailsService: PullRequestDetailsService {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchPullRequestDetailsData(_ owner: String,
                                     repository: String,
                                     id: Int,
                                     completion: @escaping (Result<PullRequestDetail, GHError>) -> Void) {
        let urlString = "repos/\(owner)/\(repository)/pulls/\(id)"

        networkManager.fetch(urlString: urlString, method: .get, parameters: [:], headers: [:]) { result in
            switch result {
            case .success(let data):
                 do {
                    let decodedObject = try GHDecoder().decode(PullRequestDetail.self, from: data)
                    completion(.success(decodedObject))
                 } catch {
                    completion(.failure(GHError.invalidData))
                 }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
