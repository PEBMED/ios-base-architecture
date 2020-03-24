//
//  PullRequestDetailsService.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

protocol PullRequestDetailsService {
    func fetchPullRequestDetailsData(_ owner: String,
                                     repository: String,
                                     id: Int,
                                     completion: @escaping (Result<PullRequestDetail, GHError>) -> Void)
}
