//
//  ImageRepository.swift
//  MovieExplorer
//
//  Created by Yohai on 19/01/2025.
//

import Combine
import UIKit

protocol ImageRepositoryProtocol {
    func fetchImage(for movie: Movie) -> AnyPublisher<UIImage, NetworkError>
    func fetchCachedImage(for movie: Movie) -> UIImage?
}

final class ImageRepository: ImageRepositoryProtocol {
    
    private let imageService: ImageServicing
    private let imageCacheService: ImageCacheServicing
    
    init(imageService: ImageServicing, imageCacheService: ImageCacheServicing) {
        self.imageService = imageService
        self.imageCacheService = imageCacheService
    }
    
    func fetchImage(for movie: Movie) -> AnyPublisher<UIImage, NetworkError> {
        
        guard let posterPath = movie.posterPath else {
            return Fail(error: NetworkError.requestFailure(statusCode: -1)).eraseToAnyPublisher()
        }
        
        if let cachedImage = fetchCachedImage(for: movie) {
            return Just(cachedImage)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        return imageService.fetchImage(size: "w500", from: posterPath)
            .handleEvents(receiveOutput: { [weak self] image in
                self?.imageCacheService.save(image, forKey: movie.id)
            })
            .eraseToAnyPublisher()
    }
    
    func fetchCachedImage(for movie: Movie) -> UIImage? {
        return imageCacheService.value(forKey: movie.id)
    }
}
