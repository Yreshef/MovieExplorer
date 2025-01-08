//
//  NetworkService.swift
//  MovieExplorer
//
//  Created by Yohai on 05/01/2025.
//

import Foundation
import Combine

protocol NetworkServicing {
    func fetch<T: Decodable>(_ type: T.Type, from route: NetworkRoutes) -> AnyPublisher<Data, NetworkError>
}

final class NetworkService: NetworkServicing {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from route: NetworkRoutes) -> AnyPublisher<Data, NetworkError> {
        
        guard var components = URLComponents(string: route.urlPath) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        if let parameters = route.parameters {
            components.queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }
        
        guard let url = components.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        
        return session
            .dataTaskPublisher(for: request)
            .tryMap { response -> Data in
                
                #if DEBUG
                if let dataString = String(data: response.data, encoding: .utf8) {
                    print("API Response: \(dataString)")
                    print("-------------END OF API RESPONSE-------------")
                }
#endif
                
                guard let resposne = response.response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard 200...299 ~= resposne.statusCode else {
                    throw NetworkError.requestFailure(statusCode: resposne.statusCode)
                }
                
                return response.data
            }
//            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.decodingFailure
            }
            .eraseToAnyPublisher()
    }
}
