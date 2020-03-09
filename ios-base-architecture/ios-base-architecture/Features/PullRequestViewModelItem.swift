//
//  PullRequestViewModelItem.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

struct PullRequestViewModelItem {
    let login: String
    let number: Int
    let title: String
    let body: String?
    let createdAt: String
    let avatarUrl: String?
}
