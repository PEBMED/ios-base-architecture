//
//  User.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 10/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let avatarUrl: String?
    let company: String?
    let name: String?
    let location: String?
    let bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let htmlUrl: String
    let following: Int?
    let followers: Int?
    let createdAt: Date?
}
