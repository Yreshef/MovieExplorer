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
    
    func fetchPopularMovies() -> AnyPublisher<ManyMoviesResponse, NetworkError>
    func fetchMovies(_ query: String) -> AnyPublisher<ManyMoviesResponse, NetworkError>
}

final class MovieService: MovieServicing {
    
    let networkService: NetworkServicing
    let decoder: JSONDecoder = {
       let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.movieAPIFormatter)
        return decoder
    }()
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
    func fetchPopularMovies() -> AnyPublisher<ManyMoviesResponse, NetworkError> {
        networkService.fetch(ManyMoviesResponse.self, from: .TMDB(route: .popularMovies))
            .tryMap { data in
                do {
                    return try self.decoder.decode(ManyMoviesResponse.self, from: data)
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
    
    func fetchMovies(_ query: String) -> AnyPublisher<ManyMoviesResponse, NetworkError> {
        networkService.fetch(ManyMoviesResponse.self, from: .TMDB(route: .searchMovies(query: query)))
            .tryMap { data in
                do {
                    return try self.decoder.decode(ManyMoviesResponse.self, from: data)
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
    private var apiParameters: [String: String] {
        ["api_key": apiKey]
    }
    
    case popularMovies
    case searchMovies(query: String)
    
    
    var urlPath: String {
        switch self {
        case .popularMovies: return path + "movie/popular"
        case .searchMovies:
            return path + "search/movie"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .searchMovies(let query):
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            var params = apiParameters
            params["query"] = encodedQuery
            return params
        case .popularMovies: return apiParameters
        }
    }
}
