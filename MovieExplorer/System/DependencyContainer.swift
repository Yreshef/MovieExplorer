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
}

final class DependencyContainer: DependencyContaining {
    
    // MARK: Contained services
    internal let networkService: NetworkServicing = NetworkService()
    internal lazy var movieService: MovieServicing = MovieService(networkService: networkService)
    internal lazy var imageService: ImageServicing = ImageService(networkService: networkService)
    internal let imageCacheService: any ImageCacheServicing = ImageCacheService(cacheService: MemoryCacheManager<Int, UIImage>())

    init() { }
}
