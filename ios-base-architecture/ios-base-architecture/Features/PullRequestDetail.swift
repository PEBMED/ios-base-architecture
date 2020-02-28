//
//  PullRequestDetail.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

struct PullRequestDetail: Codable{
    let id: Int
    let number: Int
    let changedFiles: Int
    let additions: Int
    let deletions: Int
    let title: String
    let state: String
    let body: String
    let createdAt: Date
    let base: Base
    let head: Base
}

struct PullRequestDetailViewModelItem{
    let number: String
    let changedFiles: String
    let title: String
    let state: String
    let body: String
    let createdAt: String
    let baseAvatarUrl: String
    let headAvatarUrl: String
    let fullName: String
    let additionsDeletions: NSMutableAttributedString
    let baseBranchName: String
    let headBranchName: String
    let userName: String
}

