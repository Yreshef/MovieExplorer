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
        return MovieListViewModel(movieService: container.movieService,
                                  imageService: container.imageService,
                                  imageCacheService: container.imageCacheService,
                                  persistencyManager: container.persistencyManager)
    }
}
