//
//  PullRequestDetail2.swift
//  ios-base-architecture
//
//  Created by Luiz on 10/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

struct PullRequestDetail2: Codable {
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
