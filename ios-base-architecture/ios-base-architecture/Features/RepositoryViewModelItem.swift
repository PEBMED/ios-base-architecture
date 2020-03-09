//
//  RepositoryViewModelItem.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

struct RepositoryViewModelItem {
    let login: String
    let name: String
    let description: String
    let avatarUrl: String
    let ownerName: String
    let stargazersCount: Int
    let forksCount: Int
    let openIssuesCount: Int

    init(name: String, description: String?, avatarUrl: String?, stargazersCount: Int, forksCount: Int, openIssuesCount: Int, ownerName: String, login: String) {
        self.name = name
        self.login = login
        self.description = description ?? "No description available"
        self.avatarUrl = avatarUrl ?? ""
        self.forksCount = forksCount
        self.openIssuesCount = openIssuesCount
        self.stargazersCount = stargazersCount
        self.ownerName = "• " + ownerName
    }
}
