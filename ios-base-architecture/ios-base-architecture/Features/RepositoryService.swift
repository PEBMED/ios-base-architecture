//
//  RepositoryService.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol RepositoryService {
    func fetchRepositoriesData(completion: @escaping (SearchRepositories?, String?)->Void)
}
