//
//  CoinListNetworkManager.swift
//  CoinList
//
//  Created by Armen Nikoghosyan on 18/09/2022.
//

import UIKit
import Combine

class CoinListNetworkManager: NetworkEngine {

    func update<T>(type: T.Type, url: URL, headers: Headers) async -> Data? {
        await withCheckedContinuation({ continuation in
            var urlRequest = URLRequest(url: url)
            headers.forEach { (key, value) in
                       if let value = value as? String {
                           urlRequest.setValue(value, forHTTPHeaderField: key)
                       }
                   }
           let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
               continuation.resume(returning: data)
            }
            task.resume()
        })
    }

    func get<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        var urlRequest = URLRequest(url: url)
        headers.forEach { (key, value) in
                   if let value = value as? String {
                       urlRequest.setValue(value, forHTTPHeaderField: key)
                   }
               }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
                   .map(\.data)
                   .decode(type: T.self, decoder: JSONDecoder())
                   .eraseToAnyPublisher()
    }
}
