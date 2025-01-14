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
        
        return MovieListViewController(movieService: container.movieService,
                                       imageService: container.imageService,
                                       imageCacheService: container.imageCacheService)
    }
}
