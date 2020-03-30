//
//  WebserviceRequest.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 10/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol WebserviceRequest {
    var task: URLSessionTask? { get }

    func cancel()
}
