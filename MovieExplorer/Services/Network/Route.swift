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
    case movie
    
    var urlPath: String {
        switch self {
        case .movie:
            return "/movie/"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .movie: return [:]
        }
    }
}
