//
//  NetworkService.swift
//  MovieExplorer
//
//  Created by Yohai on 05/01/2025.
//

import Foundation
import Combine

protocol NetworkServicing {
    func fetch<T: Decodable>(_ type: T.Type, from route: NetworkRoutes) -> AnyPublisher<T, NetworkError>
}

final class NetworkService: NetworkServicing {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from route: NetworkRoutes) -> AnyPublisher<T, NetworkError> {
        
        guard let url = URL(string: route.urlPath) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        
        return session
            .dataTaskPublisher(for: request)
            .tryMap { response -> Data in
                guard let resposne = response.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard 200...299 ~= resposne.statusCode else {
                    throw NetworkError.requestFailure(statusCode: resposne.statusCode)
                }
                
                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.decodingFailure
            }
            .eraseToAnyPublisher()
    }
}
