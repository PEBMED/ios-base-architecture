//
//  RepositoryViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol RepositoryViewModel {
        
    var service: RepositoryService { get }
    
    func fetchRepositories(completion: @escaping (Bool, String?)->Void)
    func getRepositoryViewModelItem(with indexPath: IndexPath)->RepositoryViewModelItem
    func getRepositoryViewModelNumberOfItems()->Int
    init(service: RepositoryService)
}
