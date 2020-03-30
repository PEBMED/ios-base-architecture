//
//  DefautPullRequestDetailsViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class DefautPullRequestDetailsViewModel: PullRequestDetailsViewModel {
    let login: String
    let repoName: String
    let pullRequestNumber: Int
    let service: PullRequestDetailsService
    private var pullRequestDetailViewModelItem: PullRequestDetailViewModelItem?

    required init(login: String, repoName: String, pullRequestNumber: Int, service: PullRequestDetailsService) {
        self.login = login
        self.repoName = repoName
        self.pullRequestNumber = pullRequestNumber
        self.service = service
    }

    func fetchPullRequests(completion: @escaping (Bool, String?) -> Void) {
        service.fetchPullRequestDetailsData(
            login,
            repository: repoName,
            id: pullRequestNumber
        ) { [weak self] result in
            switch result {
            case .success(let pullRequestDetail):
                self?.setPullRequestsDetailData(pullRequestDetail)
                completion(true, nil)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }

    func setPullRequestsDetailData(_ pullRequestsDetailData: PullRequestDetail) {
        let atributtedString = NSMutableAttributedString(
            string: "+\(pullRequestsDetailData.additions) ",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
        )
        atributtedString.append(NSAttributedString(
            string: " -\(pullRequestsDetailData.deletions)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemRed]
            )
        )

        let createdDate = pullRequestsDetailData.createdAt.convertToMonthDayYearFormat() ?? Date().description

        pullRequestDetailViewModelItem = PullRequestDetailViewModelItem(
            number: "#\(pullRequestsDetailData.number)",
            changedFiles: "\(pullRequestsDetailData.changedFiles) files changed",
            title: pullRequestsDetailData.title,
            state: pullRequestsDetailData.state,
            body: pullRequestsDetailData.body.filter { !$0.isNewline },
            createdAt: createdDate,
            baseAvatarUrl: pullRequestsDetailData.base.repo.owner.avatarUrl ?? "",
            headAvatarUrl: pullRequestsDetailData.head.repo.owner.avatarUrl ?? "",
            fullName: pullRequestsDetailData.base.repo.fullName ?? "",
            additionsDeletions: atributtedString,
            baseBranchName: pullRequestsDetailData.base.ref,
            headBranchName: pullRequestsDetailData.base.label,
            userName: pullRequestsDetailData.head.repo.owner.login
        )
    }

    func getPullRequestDetailViewModelItem() -> PullRequestDetailViewModelItem? {
        return pullRequestDetailViewModelItem
    }
}
