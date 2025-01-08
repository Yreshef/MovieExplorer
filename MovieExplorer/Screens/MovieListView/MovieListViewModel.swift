//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import UIKit
import Combine

class MovieListViewModel {
    
    @Published var movies: [Movie] = []
    @Published var images: [Int: UIImage] = [:]
    let movieService: MovieServicing
    let imageService: ImageServicing
    private var cancellables = Set<AnyCancellable>()
    
    init(movieService: MovieServicing, imageService: ImageServicing) {
        self.movieService = movieService
        self.imageService = imageService
    }
    
    func fetchMovies() {
        DispatchQueue.main.async {
            self.movieService.fetchMovie()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("An error has occured: \(error)")
                    }
                } receiveValue: { [weak self] movie in
//                    print(movie)
                    self?.movies.append(movie)
                    self?.fetchImage(for: movie)
                }
                .store(in: &self.cancellables)
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
