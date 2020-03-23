//
//  PullRequestDetailViewModelItem.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 09/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

struct PullRequestDetailViewModelItem {
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
