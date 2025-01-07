//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import Foundation
import Combine

class MovieListViewModel {
    
    var movies: [Movie] = []
    let movieService: MovieServicing
    private var cancellables = Set<AnyCancellable>()
    
    init(movieService: MovieServicing) {
        self.movieService = movieService
    }
    
    func fetchMovies() {
        movieService.fetchMovie()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("An error has occured: \(error)")
                }
            } receiveValue: { [weak self] movie in
                print(movie)
            }
            .store(in: &cancellables)
    }
    
    func fetchMockData() {
        movies = MockData.mockMovies
    }
}