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
    
    // MARK: Methods
    
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
        movieRepository.searchMovies(query: query)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("Error searching movies: \(error)")
                }
            } receiveValue: { [weak self] movies in
                self?.state = .searchResults
                self?.movies = movies.results
                
                self?.fetchImages(for: movies.results)
            }
            .store(in: &cancellables)
    }
    
    public func updateSearchQuery(query: String) {
        searchQuerySubject.send(query)
    }
    
    public func fetchImages(for movies: [Movie]) {
        
        let missingMovies = movies.filter { images[$0.id] == nil }

        let imageFetchPublisher = missingMovies.map { movie in
            self.imageRepository.fetchImage(for: movie)
                .catch { error in
                    Just(Images.placeholderPoster)
                }
                .handleEvents(receiveOutput: { [weak self] image in
                    // Update the image on the main thread
                    DispatchQueue.main.async {
                        self?.images[movie.id] = image
                        self?.notifyImageUpdate(for: movie.id)
                    }
                })
        }

        // Merge all publishers into one stream and subscribe to it
        Publishers.MergeMany(imageFetchPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("Error fetching images: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }

    
    public func fetchImage(for movie: Movie) {
        imageRepository.fetchImage(for: movie)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): print("An error has occured: \(error)")
                }
            }, receiveValue: { [weak self] image in
                self?.images[movie.id] = image
                self?.notifyImageUpdate(for: movie.id)
            })
            .store(in: &cancellables)
    }
    
    private func notifyImageUpdate(for movieID: Int) {
        imageUpdatePublisher.send(movieID)
    }
    
#if DEBUG
    public func fetchMockData() {
        movies = MockData.mockMovies
    }
#endif
}
