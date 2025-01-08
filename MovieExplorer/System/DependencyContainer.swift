//
//  DependencyContainer.swift
//  MovieExplorer
//
//  Created by Yohai on 06/01/2025.
//

import Foundation

protocol DependencyContaining {
    
    var networkService: NetworkServicing { get }
    var movieService: MovieServicing { get }
    var imageService: ImageServicing { get }
    
    func initializeServices()
    func provideMovieService() -> MovieServicing
    func provideImageService() -> ImageServicing
}

final class DependencyContainer: DependencyContaining {
    
    // MARK: Contained services
    internal let networkService: NetworkServicing = NetworkService()
    internal lazy var movieService: MovieServicing = MovieService(networkService: networkService)
    internal lazy var imageService: ImageServicing = ImageService(networkService: networkService)
    
    init() {
        initializeServices()
    }
    
    func initializeServices() {
        //Initialize here any services that require a manual launch.
    }
    
    func provideMovieService() -> MovieServicing {
        return movieService
    }
    
    func provideImageService() -> ImageServicing {
        return imageService
    }
}
