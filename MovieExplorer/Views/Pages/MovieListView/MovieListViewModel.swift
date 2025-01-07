//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import Foundation

class MovieListViewModel {
    var movies: [Movie] = []
    
    func fetchMovies() {
        //TODO: Implement
    }
    
    func fetchMockData() {
        movies = MockData.mockMovies
    }
}
