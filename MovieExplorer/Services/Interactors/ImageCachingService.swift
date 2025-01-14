//
//  ImageCachingService.swift
//  MovieExplorer
//
//  Created by Yohai on 14/01/2025.
//

import UIKit

protocol ImageCacheServicing: CacheServicable {
    func value(forKey key: Int) -> UIImage?
    func save(_ value: UIImage, forKey key: Int)
    func removeValue(forKey key: Int)
    func clearCache()
}

final class ImageCacheService<CacheType: CacheServicable>: ImageCacheServicing
    where CacheType.K == Int, CacheType.T == UIImage {

    private let cacheService: CacheType
    
    init(cacheService: CacheType) {
        self.cacheService = cacheService
    }
    
    func value(forKey key: Int) -> UIImage? {
        return cacheService.value(forKey: key)
    }
    
    func save(_ value: UIImage, forKey key: Int) {
        cacheService.save(value, forKey: key)
    }
    
    func removeValue(forKey key: Int) {
        cacheService.removeValue(forKey: key)
    }
    
    func clearCache() {
        cacheService.clearCache()
    }
}

