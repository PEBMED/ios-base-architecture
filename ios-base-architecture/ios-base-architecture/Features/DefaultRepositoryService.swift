//
//  RepositoryService.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class DefaultRepositoryService: RepositoryService {
    func fetchRepositoriesData(completion: @escaping (SearchRepositories?, String?)->Void){
        NetworkManager.shared.fetchData(stringURL: "search/repositories?q=topic:javascript&per_page=20", type: SearchRepositories.self) { (result) in
            switch result{
            case .success(let repositories):
                completion(repositories, nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            }
        }
    }
}
