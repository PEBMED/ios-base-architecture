//
//  RepositoryViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class DefaultRepositoryViewModel: RepositoryViewModel {
    
    private var searchRepositories: SearchRepositories?
    private var repositoriesViewModelItem: [RepositoryViewModelItem]
    let service: RepositoryService
    
    required init(service: RepositoryService) {
        self.service = service
        repositoriesViewModelItem = [RepositoryViewModelItem]()
    }
    
    func fetchRepositories(completion: @escaping (Bool, String?)->Void){
        service.fetchRepositoriesData { [weak self] (searchRepostioriesData, errorMessage) in
            
            guard let searchRepostioriesData = searchRepostioriesData else {
                completion(false, errorMessage ?? "Default error message")
                return
            }
            
            self?.searchRepositories = searchRepostioriesData
            
            self?.repositoriesViewModelItem = searchRepostioriesData.items.map { (repository) -> RepositoryViewModelItem in
                return RepositoryViewModelItem(name: repository.name, description: repository.description, avatarUrl: repository.owner.avatarUrl, stargazersCount: repository.stargazersCount, forksCount: repository.forksCount, openIssuesCount: repository.openIssuesCount, ownerName: repository.owner.login)
            }
            
            completion(true, nil)
        }
    }
    
    func getRepositoryViewModelItem(with indexPath: IndexPath)->RepositoryViewModelItem{
        return repositoriesViewModelItem[indexPath.item]
    }
    
    func getRepositoryViewModelNumberOfItems()->Int{
        return repositoriesViewModelItem.count
    }
}



