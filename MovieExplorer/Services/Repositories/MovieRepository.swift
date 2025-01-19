//
//  MovieRepository.swift
//  MovieExplorer
//
//  Created by Yohai on 18/01/2025.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func getPopularMovies() -> AnyPublisher<ManyMoviesResponse, NetworkError>
    func searchMovies(query: String) -> AnyPublisher<ManyMoviesResponse, NetworkError>
}

final class MovieRepository: MovieRepositoryProtocol {
    
    private let movieService: MovieServicing
    
    init(movieService: MovieServicing) {
        self.movieService = movieService
    }
    
    func getPopularMovies() -> AnyPublisher<ManyMoviesResponse, NetworkError> {
        return movieService.fetchPopularMovies().eraseToAnyPublisher()
    }
    
    func searchMovies(query: String) -> AnyPublisher<ManyMoviesResponse, NetworkError> {
        return movieService.fetchMovies(query).eraseToAnyPublisher()
    }
}
