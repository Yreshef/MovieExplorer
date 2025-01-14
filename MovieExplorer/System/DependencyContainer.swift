//
//  DependencyContainer.swift
//  MovieExplorer
//
//  Created by Yohai on 06/01/2025.
//

import UIKit

protocol DependencyContaining {
    
    var networkService: NetworkServicing { get }
    var movieService: MovieServicing { get }
    var imageService: ImageServicing { get }
    var imageCacheService: any ImageCacheServicing { get }
    
    func initializeServices()
    func provideMovieService() -> MovieServicing
    func provideImageService() -> ImageServicing
}

final class DependencyContainer: DependencyContaining {    
    
    // MARK: Contained services
    internal let networkService: NetworkServicing = NetworkService()
    internal lazy var movieService: MovieServicing = MovieService(networkService: networkService)
    internal lazy var imageService: ImageServicing = ImageService(networkService: networkService)
    internal let imageCacheService: any ImageCacheServicing = ImageCacheService(cacheService: CacheService<Int, UIImage>())

    
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
