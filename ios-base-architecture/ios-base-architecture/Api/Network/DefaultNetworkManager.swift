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

    func downloadImage(stringURL: String, completion: @escaping (UIImage?) -> Void) {
        if let image = DefaultNetworkManager().cache.object(forKey: NSString(string: stringURL)) {
            completion(image)
            return
        }

        guard let url = URL(string: stringURL) else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                print(GHError.fetchImage.rawValue)
                completion(nil)
                return
            }

            DefaultNetworkManager().cache.setObject(image, forKey: NSString(string: stringURL))
            completion(image)
        }
        .resume()

        print("Deinit DefaultNetworkManager")
        requests.forEach { $0.cancel() }

        print("Deinit DefaultNetworkManager")
        requests.forEach { $0.cancel() }

        print("Deinit DefaultNetworkManager")
        requests.forEach { $0.cancel() }
    }

    deinit {
      print("Deinit DefaultNetworkManager")
      requests.forEach { $0.cancel() }
    }
}
