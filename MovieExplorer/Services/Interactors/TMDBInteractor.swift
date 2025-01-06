//
//  TMDBInteractor.swift
//  MovieExplorer
//
//  Created by Yohai on 05/01/2025.
//

import Foundation

protocol TMDBInteracting {
    //TODO: Implement
}

final class TMDBInteractor: TMDBInteracting {
    //TODO: Implement
}

enum TMDBRoute: Route {
    
    private var path: String {
        "Path"
    }
    
    case movie
    
    var urlPath: String {
        switch self {
            case .movie: return path + "movie/"
        }
    }
    
    var parameters: [String: Any]? { return nil }
}
