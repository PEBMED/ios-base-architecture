//
//  DefautPullRequestDetailsViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class DefautPullRequestDetailsViewModel: PullRequestDetailsViewModel {
    
    let pullRequest: PullRequest
    let service: PullRequestDetailsService
    var pullRequestDetail: PullRequestDetail?
    private var pullRequestDetailViewModelItem: PullRequestDetailViewModelItem?
    
    required init(_ pullRequest: PullRequest, service: PullRequestDetailsService) {
        self.pullRequest = pullRequest
        self.service = service
    }
    
    func fetchPullRequests(completion: @escaping (Bool, String?)->Void){
        service.fetchPullRequestDetailsData(pullRequest.base.repo.owner.login, repository: pullRequest.base.repo.name, id: pullRequest.number) { [weak self] (pullRequestDetail, errorMessage) in
            
            guard let pullRequestsData = pullRequestDetail else {
                completion(false, errorMessage ?? "")
                return
            }
            
            self?.setPullRequestsDetailData(pullRequestsData)
            completion(true, nil)
        }
    }
    
    func setPullRequestsDetailData(_ pullRequestsDetailData: PullRequestDetail){
        self.pullRequestDetail = pullRequestsDetailData
        
        let atributtedString = NSMutableAttributedString(string: "+\(pullRequestsDetailData.additions) ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen])
        atributtedString.append(NSAttributedString(string: " -\(pullRequestsDetailData.deletions)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemRed]))
        
        let createdDate = pullRequestsDetailData.createdAt.convertToMonthDayYearFormat() ?? Date().description
        
        pullRequestDetailViewModelItem = PullRequestDetailViewModelItem(number: "#\(pullRequestsDetailData.number)",
                                       changedFiles: "\(pullRequestsDetailData.changedFiles) files changed",
                                       title: pullRequestsDetailData.title,
                                       state: pullRequestsDetailData.state,
                                       body: pullRequestsDetailData.body.filter({!$0.isNewline}),
                                       createdAt: createdDate,
                                       baseAvatarUrl: pullRequestsDetailData.base.repo.owner.avatarUrl ?? "",
                                       headAvatarUrl: pullRequestsDetailData.head.repo.owner.avatarUrl ?? "",
                                       fullName: pullRequestsDetailData.base.repo.fullName ?? "",
                                       additionsDeletions: atributtedString,
                                       baseBranchName: pullRequestsDetailData.base.ref,
                                       headBranchName: pullRequestsDetailData.base.label,
                                       userName: pullRequestsDetailData.head.repo.owner.login)
    }
    
    func getPullRequestDetailViewModelItem() -> PullRequestDetailViewModelItem? {
        return pullRequestDetailViewModelItem
    }
}
