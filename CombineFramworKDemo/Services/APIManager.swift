//
//  APIManager.swift
//  CombineFramworKDemo
//
//  Created by Avinash on 20/06/21.
//

import Foundation
import Combine
class ApiManager {

    static let shared = ApiManager()
    var subscriber = Set<AnyCancellable>()
    func fetchUser<T: Decodable> (url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [T].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (comoletionVlaue) in
                switch comoletionVlaue {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            }) { (result) in
                completion(.success(result))
        }.store(in: &subscriber)
    }
}
