//
//  PullRequestViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol PullRequestViewModel {
    var ownerName: String { get }
    var projectName: String { get }
    var hasMoreData: Bool { get set }
    
    init(_ repository: Repository, service: PullRequestService)
    
    func fetchPullRequests(completion: @escaping (Bool, String?)->Void)->Void
    func getPullRequestViewModelItem(with indexPath: IndexPath)->PullRequestViewModelItem
    func getPullRequestViewModelNumberOfItems()->Int
}
