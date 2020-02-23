//
//  Repository.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

struct SearchRepositories: Codable {
    let items: [Repository]
}


struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String?
    let description: String?
    let owner: Owner
    let stargazersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
}

struct Owner: Codable {
    let id: Int
    let login: String
    let avatarUrl: String?
}
