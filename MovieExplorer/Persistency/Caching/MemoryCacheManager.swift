//
//  MemoryCacheManager.swift
//  MovieExplorer
//
//  Created by Yohai on 13/01/2025.
//

import Foundation

protocol MemoryCacheManaging {
    associatedtype K: Hashable
    associatedtype T
    
    func value(forKey key: K) -> T?
    func save(_ value: T, forKey key: K)
    func removeValue(forKey key: K)
    func clearCache()
}

final class MemoryCacheManager<K: Hashable, T>: MemoryCacheManaging {
    private let cache = NSCache<CacheKey, Entry>()
    
    private final class CacheKey: NSObject {
        
        let key: K
        override var hash: Int {
            return key.hashValue
        }
        
        init(key: K) {
            self.key = key
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let other = object as? CacheKey else { return false }
            return other.key == key
        }
    }
    
    private class Entry {
        let value: T
        init(value: T) {
            self.value = value
        }
    }
    
    func value(forKey key: K) -> T? {
        return cache.object(forKey: CacheKey(key: key))?.value
    }
    
    func save(_ value: T, forKey key: K) {
        let entry = Entry(value: value)
        cache.setObject(entry, forKey: CacheKey(key: key))
    }
    
    func removeValue(forKey key: K) {
        cache.removeObject(forKey: CacheKey(key: key))
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
