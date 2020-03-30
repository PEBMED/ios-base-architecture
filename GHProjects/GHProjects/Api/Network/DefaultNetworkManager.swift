//
//  DefaultNetworkManager.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class DefaultNetworkManager: NetworkManager {
    private var requests: [WebserviceRequest] = []
    private let cache = NSCache<NSString, UIImage>()
    private let baseUrl: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("No such url as BASE_URL in info.plist")
        }
        return url
    }()

    func fetch(urlString: String,
               method: HTTPMethod,
               parameters: [String: Any],
               headers: [String: String],
               completion: @escaping (Result<Data, GHError>) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(urlString)") else {
            completion(.failure(GHError.invalidURL))
            return
        }
        let request = DefaultDataRequest(url: url, method: method, parameters: parameters, headers: headers)
        request.responseData { [weak self] result in
            guard let self = self else { return }
            self.requests.removeAll { $0.task?.hashValue == request.task?.hashValue }

            completion(result)
        }
        self.requests.append(request)
    }

    deinit {
      print("DEINIT DefaultNetworkManager")
      requests.forEach { $0.cancel() }
    }
}
