//
//  UserDetailService.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

final class DefaultUserDetailService: UserDetailService {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = DefaultNetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchUserDetailData(userName: String, completionHandler: @escaping (Result<User, GHError>) -> Void) {
        networkManager.fetch(urlString: "users/\(userName)", method: .get, parameters: [:], headers: [:]) { result in
            switch result {
            case .success (let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .iso8601
                    let user = try decoder.decode(User.self, from: data)
                    completionHandler(.success(user))
                } catch {
                    completionHandler(.failure(GHError.invalidData))
                }
            case .failure (let error):
                completionHandler(.failure(error))
            }
        }
    }
}
