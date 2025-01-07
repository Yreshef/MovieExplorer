//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import Foundation

class MovieListViewModel {
    
    var movies: [Movie] = []
    let movieService: MovieServicing
    
    init(movieService: MovieServicing) {
        self.movieService = movieService
    }
    
    func fetchMovies() {
        //TODO: Implement
    }
    
    func fetchMockData() {
        movies = MockData.mockMovies
    }
}
