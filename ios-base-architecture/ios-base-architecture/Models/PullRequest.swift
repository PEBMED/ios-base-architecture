//
//  PullRequest.swift
//  ios-base-architecture
//
//  Created by Luiz on 25/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

struct PullRequest: Codable {
    let id: Int
    let number: Int
    let title: String
    let body: String?
    let createdAt: Date
    let user: User
    let base: Base
}
