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
    
    //TODO: Replace with actual implementation
    func fetchMovie() -> AnyPublisher<Movie, NetworkError> {
        networkService.fetch(Movie.self, from: .TMDB(route: .gladiatorII))
            .tryMap { data in
                // Decode the raw JSON data into MovieResponse (or Movie if it's a single object)
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(Movie.self, from: data)
                } catch {
                    throw NetworkError.decodingFailure
                }
            }
            .mapError { error in
                // Map the error to your custom NetworkError type
                if let networkError = error as? NetworkError {
                    return networkError
                } else {
                    return NetworkError.requestFailure(statusCode: -1) // Handle general error
                }
            }
            .eraseToAnyPublisher() // Return a publisher of Movie or error
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
