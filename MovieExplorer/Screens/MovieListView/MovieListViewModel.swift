//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import UIKit
import Combine

enum MovieListState {
    case popularMovies
    case searchResults
}

class MovieListViewModel {
    
    @Published var movies: [Movie] = []
    @Published var state: MovieListState = .popularMovies
    @Published var favorites: [Movie] = []
    @Published var images: [Int: UIImage] = [:]
    private var cancellables = Set<AnyCancellable>()
    
    let movieService: MovieServicing
    let imageService: ImageServicing
    
    init(movieService: MovieServicing, imageService: ImageServicing) {
        self.movieService = movieService
        self.imageService = imageService
        fetchPopularMovies()
    }
    
//    public func fetchMovies() {
//        DispatchQueue.main.async {
//            self.movieService.fetchMovie()
//                .receive(on: DispatchQueue.main)
//                .sink { [weak self] completion in
//                    switch completion {
//                    case .finished:
//                        break
//                    case .failure(let error):
//                        print("An error has occured: \(error)")
//                    }
//                } receiveValue: { [weak self] movie in
//                    self?.movies.append(movie)
//                    self?.fetchImage(for: movie)
//                }
//                .store(in: &self.cancellables)
//        }
//    }
    
    public func fetchPopularMovies() {
        self.movieService.fetchPopularMovies()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("An error has occured: \(error)")
                }
            } receiveValue: { [weak self] movies in
                self?.state = .popularMovies
                self?.movies = movies.results
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorites(movie: Movie) {
        if favorites.contains(where: { $0.id == movie.id }) {
            favorites.removeAll { $0.id == movie.id }
        } else {
            favorites.append(movie)
        }
    }
    
    private func fetchImage(for movie: Movie) {
        guard let posterPath = movie.posterPath else { return }
        
        imageService.fetchImage(size: "w500", from: posterPath)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("An error has occured: \(error)")
                }
            } receiveValue: { [weak self] image in
                self?.images[movie.id] = image
            }
            .store(in: &cancellables)
    }
    
    func fetchMockData() {
        movies = MockData.mockMovies
    }
}
