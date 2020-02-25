//
//  DefaultPullRequestService.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

final class DefaultPullRequestService: PullRequestService {
    
    private var page = 1
    //var hasMoreFollowers = true
    
    func fetchPullRequestData(_ owner: String, repository: String, completion: @escaping ([PullRequest]?, String?, Bool)->Void){
        NetworkManager.shared.fetchData(stringURL: "repos/\(owner)/\(repository)/pulls?per_page=20&page=\(page)", type: [PullRequest].self) { [weak self] (result) in
            //guard let self = self else {return}
            switch result{
            case .success(let prs):                
                completion(prs, nil, false)
            case .failure(let error):
                completion(nil, error.rawValue, false)
            }
        }
    }
}
