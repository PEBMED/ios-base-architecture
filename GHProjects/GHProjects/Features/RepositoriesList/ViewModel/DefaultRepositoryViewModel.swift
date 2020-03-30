//
//  RepositoryViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class DefaultRepositoryViewModel: RepositoryViewModel {
    // MARK: - Properties
    private var repositoriesViewModelItem: [RepositoryViewModelItem]
    private let service: RepositoryService
    private(set) var hasMoreData = true

    // MARK: - Init
    required init(service: RepositoryService) {
        self.service = service
        repositoriesViewModelItem = [RepositoryViewModelItem]()
    }

    // MARK: - RepositoryViewModel
    func fetchRepositories(completion: @escaping (Bool, String?) -> Void) {
        service.fetchRepositoriesData { [weak self] result, hasMoreData in
            guard let self = self else { return }

            switch result {
            case .success(let searchRepostioriesData):
                self.hasMoreData = hasMoreData
                self.setSearchReposityData(searchRepostioriesData)
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }

    func getRepositoryViewModelItem(with indexPath: IndexPath) -> RepositoryViewModelItem {
        return repositoriesViewModelItem[indexPath.item]
    }

    func getRepositoryViewModelNumberOfItems() -> Int {
        return repositoriesViewModelItem.count
    }

    // MARK: - Private
    private func setSearchReposityData(_ searchRepostioriesData: SearchRepositories) {
        repositoriesViewModelItem += searchRepostioriesData.items.map { repository -> RepositoryViewModelItem in
            return RepositoryViewModelItem(name: repository.name,
                                           description: repository.description,
                                           avatarUrl: repository.owner.avatarUrl,
                                           stargazersCount: repository.stargazersCount,
                                           forksCount: repository.forksCount,
                                           openIssuesCount: repository.openIssuesCount,
                                           ownerName: repository.owner.login,
                                           login: repository.owner.login)
        }
    }
}
