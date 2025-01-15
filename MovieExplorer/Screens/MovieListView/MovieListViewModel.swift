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

//TODO: Refactor View Model to handle less responsibility, to keep it simpler and easier to maintain

class MovieListViewModel {
    
    @Published var movies: [Movie] = []
    @Published var state: MovieListState = .popularMovies 
    @Published var updatedMovie: Movie?
    @Published var favorites: [Movie] = []
    @Published var images: [Int: UIImage] = [:]
    
    private var searchQuerySubject = PassthroughSubject<String, Never>()
    let imageUpdatePublisher = PassthroughSubject<Int, Never>()
    
    private var cancellables = Set<AnyCancellable>()

    let movieService: MovieServicing
    let imageService: ImageServicing
    let imageCacheService: any ImageCacheServicing
    
    init(movieService: MovieServicing, imageService: ImageServicing, imageCacheService: any ImageCacheServicing) {
        self.movieService = movieService
        self.imageService = imageService
        self.imageCacheService = imageCacheService
        setupSearchQueryObject()
        fetchPopularMovies()
    }
    
    private func setupSearchQueryObject() {
        searchQuerySubject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main) 
            .removeDuplicates() // Avoid duplicate requests if the query hasn't changed
            .sink(receiveValue: { [weak self] query in
                self?.searchMovie(query: query)
            })
            .store(in: &cancellables)
    }
    
    public func searchMovie(query: String) {
        if query.isEmpty {
            fetchPopularMovies()
            return
        }
        movieService.fetchMovie(query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error searching movies: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] movies in
                self?.state = .searchResults
                self?.movies = movies.results
            })
            .store(in: &cancellables)
    }
    
    public func updateSearchQuery(query: String) {
        searchQuerySubject.send(query)
    }
    
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
                self?.fetchImage(for: movies.results)
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
    
    public func fetchImage(for movie: Movie) {
        guard let posterPath = movie.posterPath else { return }
        
        if let cachedImage = imageCacheService.value(forKey: movie.id) {
            self.images[movie.id] = cachedImage
            self.notifyImageUpdate(for: movie.id)
            return
        }
        
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
                guard let self = self else { return }
                
                self.imageCacheService.save(image, forKey: movie.id)
                
                self.images[movie.id] = image
                self.notifyImageUpdate(for: movie.id)
            }
            .store(in: &cancellables)
    }
    
    private func notifyImageUpdate(for movieID: Int) {
        imageUpdatePublisher.send(movieID)
    }
    
    private func fetchImage(for movies: [Movie]) {
        for movie in movies {
            fetchImage(for: movie)
        }
    }
    
    func fetchMockData() {
        movies = MockData.mockMovies
    }
}
