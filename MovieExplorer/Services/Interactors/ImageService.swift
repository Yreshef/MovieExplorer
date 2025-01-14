//
//  ImageService.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import UIKit
import Combine

/*/
 TMDB supports various image sizes. Common sizes include:
 Posters: w92, w154, w185, w342, w500, w780, original
 Backdrops: w300, w780, w1280, original
 Profiles: w45, w185, h632, original
 Logos: w45, w92, w154, w185, w300, w500, original
 */

protocol ImageServicing {
    func fetchImage(size: String, from filePath: String) -> AnyPublisher<UIImage, NetworkError>
    
    var networkService: NetworkServicing { get }
}

class ImageService: ImageServicing {
    
    var networkService: NetworkServicing
    
    init(networkService: NetworkServicing) {
        self.networkService = networkService
    }
    
    /// Fetches an image from the specified path and size.
    /// This function constructs the URL for the image based on the provided size and path parameters,
    /// and uses the network service to fetch the image data, which is then returned as a `Publisher`.
    /// - Parameters:
    ///   - size: A string representing the size of the image (e.g., "w500" for a 500px wide image).
    ///   - path: The path to the image, typically provided by an API (e.g., "/path/to/image.jpg").
    /// - Returns: A publisher that emits the fetched image as an `Image` or a `NetworkError` in case of failure.
    func fetchImage(size: String, from path: String) -> AnyPublisher<UIImage, NetworkError> {
        networkService.fetch(Data.self, from: .TMDBImage(route: .image(size: size, filePath: path)))
            .tryMap { data -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw NetworkError.decodingFailure
                }
                return image
            }
            .mapError { error in
                return error as? NetworkError ?? NetworkError.unknown
            }
            .eraseToAnyPublisher()
    }
}

enum TMDBImageRoute: Route {
    
    private var path: String {
        "https://image.tmdb.org/t/p/"
    }
    
    case image(size: String, filePath: String)
    
    var urlPath: String {
        switch self {
        case .image(let size, let filePath):
            //Ensures filePath has a leading slash
            let correctedFilePath = filePath.hasPrefix("/") ? filePath : "/" + filePath
            return path + size + correctedFilePath
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .image: return nil
        }
    }
}
