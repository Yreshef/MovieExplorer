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
    let apiKey = "6e1720a46baa627e179c95d3e747eaf9"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from route: NetworkRoutes) -> AnyPublisher<T, NetworkError> {
        
        guard let url = URL(string: route.urlPath) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "api_key")
        
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
