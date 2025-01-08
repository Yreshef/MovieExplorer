//
//  TMDBInteractor.swift
//  MovieExplorer
//
//  Created by Yohai on 05/01/2025.
//

import Foundation
import Combine

protocol MovieServicing {
    var networkService: NetworkServicing { get }
    
    func fetchMovie() -> AnyPublisher<Movie, NetworkError>
}

final class MovieService: MovieServicing {
    
    let networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
    func fetchMovie() -> AnyPublisher<Movie, NetworkError> {
        networkService.fetch(Movie.self, from: .TMDB(route: .gladiatorII))  //TODO: replace with different route
            .tryMap { data in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(Movie.self, from: data)
                } catch {
                    throw NetworkError.decodingFailure
                }
            }
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.requestFailure(statusCode: -1)
                }
            }
            .eraseToAnyPublisher()
    }
}

enum TMDBRoute: Route {
    
    private var path: String {
        "https://api.themoviedb.org/3/"
    }
    private var apiKey: String {
        APIKeys.movieDBKey
    }//TODO: Change to env. variable later on
    
    case movie
    case gladiatorII
    
    var urlPath: String {
        switch self {
        case .movie: return path + "movie/"
        case .gladiatorII: return path + "movie/558449"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .movie: return nil
        case .gladiatorII: return ["api_key": apiKey]
        }
    }
}
