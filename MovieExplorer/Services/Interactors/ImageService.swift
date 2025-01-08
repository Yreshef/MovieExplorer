//
//  ImageService.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import UIKit
import Combine

protocol ImageServicing {
    func fetchImage(size: String, from path: String) -> AnyPublisher<Image, NetworkError>
    
    var networkService: NetworkServicing { get }
}

class ImageService: ImageServicing {
    
    var networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
    func fetchImage(size: String, from path: String) -> AnyPublisher<Image, NetworkError> {
        networkService.fetch(Image.self, from: .TMDBImage(route: .image(size: size, path: path)))
    }
    
    
}

enum TMDBImageRoute: Route {
    
    private var path: String {
        "https://image.tmdb.org/t/p/"
    }
    
    case image(size: String, path: String)
    
    var urlPath: String {
        switch self {
        case .image(let size, let path): return ""
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .image(let size, let path): return [:]
        }
    }
}
