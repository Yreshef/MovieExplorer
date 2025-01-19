//
//  MovieListViewControllerFactory.swift
//  MovieExplorer
//
//  Created by Yohai on 14/01/2025.
//

import UIKit

final class MovieListViewControllerFactory {
    
    private let container: DependencyContaining
    
    init(dependencyContainer: DependencyContaining) {
        self.container = dependencyContainer
    }
    
    func createMovieListViewController() -> MovieListViewController {
        let viewModel = createMovieListViewModel()
        return MovieListViewController(viewModel)
    }
    
    private func createMovieListViewModel() -> MovieListViewModel {
        let movieRespoitory: MovieRepositoryProtocol = MovieRepository(movieService: container.movieService)
        return MovieListViewModel(movieRepository: movieRespoitory,
                                  imageService: container.imageService,
                                  persistencyManager: container.persistencyManager)
    }
}
