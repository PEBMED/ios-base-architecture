//
//  NetworkManager.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
    
    func fetchData<T: Codable>(stringURL: String, type: T.Type, completion: @escaping (Result<T, GHError>)->Void){
        guard let url = URL(string: baseUrl+stringURL) else {return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(GHError.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            guard let data = data, let decodedObject = try? decoder.decode(type, from: data) else {
                completion(.failure(GHError.invalidData))
                return
            }
            
            completion(.success(decodedObject))
        }
        
        dataTask.resume()
    }
    
    func downloadImage(stringURL: String, completion: @escaping (UIImage?)->Void){
        
        if let image = NetworkManager.shared.cache.object(forKey: NSString(string: stringURL)){
            completion(image)
            return
        }
        
        guard let url = URL(string: stringURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                print(GHError.fetchImage.rawValue)
                completion(nil)
                return
            }
            
            NetworkManager.shared.cache.setObject(image, forKey: NSString(string: stringURL))
            completion(image)
            
        }.resume()
    }
}
