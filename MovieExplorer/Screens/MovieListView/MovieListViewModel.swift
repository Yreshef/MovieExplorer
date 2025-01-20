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
    case loading
    case empty
}

class MovieListViewModel {
    
    @Published var movies: [Movie] = []
    @Published var images: [Int: UIImage] = [:]
    @Published var state: MovieListState = .loading
    
    private var searchQuerySubject = PassthroughSubject<String, Never>()
    private var searchCancellable: AnyCancellable?
    
    let imageUpdatePublisher = PassthroughSubject<Int, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Services
    
    let movieRepository: MovieRepositoryProtocol
    let imageRepository: ImageRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol,
         imageRepository: ImageRepositoryProtocol) {
        
        self.movieRepository = movieRepository
        self.imageRepository = imageRepository
        
        setupSearchQueryObject()
        fetchPopularMovies()
    }
    
    // MARK: Public Methods
    
    public func fetchPopularMovies() {
        movieRepository.getPopularMovies()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.state = .empty
                    print("An error has occured: \(error)")
                }
            }, receiveValue: { [weak self] movies in
                self?.state = .popularMovies
                self?.movies = movies.results
                
                self?.fetchImages(for: movies.results)
            })
            .store(in: &cancellables)
    }
    
    public func searchMovie(query: String) {
        if query.isEmpty {
            clearSearchResults()
            return
        }
        
        handleSearchQueryChange(for: query)
    }
    
    public func fetchImages(for movies: [Movie]) {
        let missingMovies = movies.filter { images[$0.id] == nil }
        
        Publishers.MergeMany(missingMovies.map { movie in
            self.imageRepository.fetchImage(for: movie)
                .catch { _ in Just(Images.placeholderPoster) }
                .map { (movie.id, $0 ) }
        })
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished: break
            case .failure(let error): print("Error fetching images: \(error)")
            }
        }, receiveValue: { [weak self] (movieID, image) in
            self?.images[movieID] = image
            self?.notifyImageUpdate(for: movieID)
        })
        .store(in: &cancellables)
    }
    
    public func updateSearchQuery(query: String) {
        searchQuerySubject.send(query)
    }
    
    public func clearSearchResults() {
        if !movies.isEmpty {
            fetchPopularMovies()
        }
        movies = []
        fetchImages(for: movies)
    }
    
    // MARK: Private Helper Methods
    
    
    private func notifyImageUpdate(for movieID: Int) {
        imageUpdatePublisher.send(movieID)
    }
    
    private func setupSearchQueryObject() {
        searchQuerySubject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates() // Avoid duplicate requests if the query hasn't changed
            .sink(receiveValue: { [weak self] query in
                
                self?.handleSearchQueryChange(for: query)
            })
            .store(in: &cancellables)
    }
    
    private func handleSearchQueryChange(for query: String) {
        if query.isEmpty {
            clearSearch()
            return
        }
        
        searchCancellable?.cancel()
        
        searchCancellable = movieRepository.searchMovies(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("Error searching movies: \(error)")
                }
            }, receiveValue: { [weak self] movies in
                self?.state = .searchResults
                self?.movies = movies.results
                self?.fetchImages(for: movies.results)
            })
    }
    
    private func clearSearch() {
        searchCancellable?.cancel()
        searchCancellable = nil
        
        fetchPopularMovies()
    }
    
#if DEBUG
    public func fetchMockData() {
        movies = MockData.mockMovies
    }
#endif
}
