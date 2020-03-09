//
//  PullRequestViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class DefaultPullRequestViewModel: PullRequestViewModel {
    let ownerName: String
    let repoName: String
    var hasMoreData: Bool = true

    let service: PullRequestService

    private var pullRequestViewModelItens = [PullRequestViewModelItem]()

    required init(ownerName: String, repoName: String, service: PullRequestService) {
        self.ownerName = ownerName
        self.repoName = repoName
        self.service = service
    }

    func fetchPullRequests(completion: @escaping (Bool, String?) -> Void) {
        service.fetchPullRequestData(ownerName, repository: repoName) { [weak self] pullRequestsData, errorMessage, hasMoreData in
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
        pullRequestViewModelItens += pullRequestsData.map { item -> PullRequestViewModelItem in
            let strDate = item.createdAt.convertToMonthDayYearFormat() ?? Date().description
            let body = item.body?.filter { !$0.isNewline }
            return PullRequestViewModelItem(login: item.user.login,
                                            number: item.number,
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

    func didSelectPullRequest(indexPath: IndexPath) -> UIViewController {
        let viewModelItem = getPullRequestViewModelItem(with: indexPath)

        let pullRequestDetailViewModel = DefautPullRequestDetailsViewModel(login: ownerName,
                                                                           repoName: repoName,
                                                                           pullRequestNumber: viewModelItem.number,
                                                                           service: DefaultPullRequestDetailsService())

        return PullRequestDetailViewController(viewModel: pullRequestDetailViewModel)
    }
}
