//
//  PullRequestViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

class DefaultPullRequestViewModel: PullRequestViewModel {
    let ownerName: String
    let projectName: String
    var hasMoreData: Bool = true

    let service: PullRequestService

    private var pullRequests = [PullRequest]()
    private var pullRequestViewModelItens = [PullRequestViewModelItem]()

    required init(_ repository: Repository, service: PullRequestService) {
        self.ownerName = repository.owner.login
        self.projectName = repository.name
        self.service = service
    }

    func fetchPullRequests(completion: @escaping (Bool, String?) -> Void) {
        service.fetchPullRequestData(ownerName, repository: projectName) { [weak self] pullRequestsData, errorMessage, hasMoreData in
            guard let pullRequestsData = pullRequestsData else {
                completion(false, errorMessage ?? "Default error message")
                return
            }

            self?.hasMoreData = hasMoreData
            self?.setPullRequestsData(pullRequestsData)
            completion(true, nil)
        }
    }

    func setPullRequestsData(_ pullRequestsData: [PullRequest]) {
        pullRequests = pullRequestsData
        pullRequestViewModelItens += pullRequestsData.map { item -> PullRequestViewModelItem in
            let strDate = item.createdAt.convertToMonthDayYearFormat() ?? Date().description
            let body = item.body?.filter { !$0.isNewline }
            return PullRequestViewModelItem(login: item.user.login,
                                            title: item.title,
                                            body: body,
                                            createdAt: strDate,
                                            avatarUrl: item.user.avatarUrl)
        }
    }
        
    func getPullRequestViewModelItem(with indexPath: IndexPath) -> PullRequestViewModelItem {
        return pullRequestViewModelItens[indexPath.item]
    }
    
    func getPullRequestViewModelNumberOfItems() -> Int {
        return pullRequestViewModelItens.count
    }
}
