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
    
    func initializeServices()
    func provideMovieService() -> MovieServicing
}

final class DependencyContainer: DependencyContaining {
    
    // MARK: Contained services
    internal let networkService: NetworkServicing = NetworkService()
    internal lazy var movieService: MovieServicing = MovieService(networkService: networkService)
    
    init() {
        initializeServices()
    }
    
    func initializeServices() {
        //Initialize here any services that require a manual launch.
    }
    
    func provideMovieService() -> MovieServicing {
        return movieService
    }
}
