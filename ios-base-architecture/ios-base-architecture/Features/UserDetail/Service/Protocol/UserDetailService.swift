//
//  UserDetailServiceProtocol.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol UserDetailService {
    func fetchUserDetailData(userName: String, completionHandler: @escaping (Result<User, GHError>) -> Void)
}
