//
//  ServicesContainer.swift
//  MovieExplorer
//
//  Created by Yohai on 07/01/2025.
//

import Foundation

protocol ServicesContaining {
    var movieService: MovieServicing { get }
    var networkService: NetworkServicing { get }
}

//class ServicesContainer: ServicesContaining {
//    var networkService: NetworkServicing {
//        return NetworkService()
//    }
//    lazy var movieService: MovieServicing {
//        return MovieService(networkService: networkService)
//    }
//}
