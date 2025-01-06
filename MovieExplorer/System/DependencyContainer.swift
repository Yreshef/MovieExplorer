//
//  DependencyContainer.swift
//  MovieExplorer
//
//  Created by Yohai on 06/01/2025.
//

import Foundation

protocol DependencyContaining {
    func initializeServices()
    var networkService: NetworkServicing { get }
}

final class DependencyContainer: DependencyContaining {
    
    // MARK: Contained services
    let networkService: NetworkServicing = NetworkService()
    
    init() {
        initializeServices()
    }
    
    func initializeServices() {
        //Initialize here any services that require a manual launch.
    }
}
