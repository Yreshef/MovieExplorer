//
//  Route.swift
//  MovieExplorer
//
//  Created by Yohai on 05/01/2025.
//

import Foundation

protocol Route {
    var urlPath: String { get }
    var parameters: [String: Any]? { get }
}

enum NetworkRoutes: Route {
    
    case TMDB(route: TMDBRoute)
    case TMDBImage(route: TMDBImageRoute)
    
    var urlPath: String {
        switch self {
        case .TMDB(let route): return route.urlPath
        case .TMDBImage(let route): return route.urlPath
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .TMDB(let route): route.parameters
        case .TMDBImage(let route): route.parameters
        }
    }
}
