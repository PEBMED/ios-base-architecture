//
//  NetworkManager.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 10/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol NetworkManager {
    func fetch(urlString: String,
               method: HTTPMethod,
               parameters: [String: Any],
               headers: [String: String],
               completion: @escaping (Result<Data, GHError>) -> Void)
}
