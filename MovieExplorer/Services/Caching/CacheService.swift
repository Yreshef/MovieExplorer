//
//  CacheService.swift
//  MovieExplorer
//
//  Created by Yohai on 13/01/2025.
//

import Foundation

protocol CacheServicable {
    associatedtype K: Hashable
    associatedtype T
    
    func value(forKey key: K) -> T?
    func save(_ value: T, forKey key: K)
    func removeValue(forKey key: K)
    func clearCache()
}

final class CacheService<K: Hashable, T>: CacheServicable {
    private let cache = NSCache<WrappedKey, Entry>()
    
    private final class WrappedKey: NSObject {
        
        let key: K
        override var hash: Int {
            return key.hashValue
        }
        
        init(key: K) {
            self.key = key
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let other = object as? WrappedKey else { return false }
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
        return cache.object(forKey: WrappedKey(key: key))?.value
    }
    
    func save(_ value: T, forKey key: K) {
        let entry = Entry(value: value)
        cache.setObject(entry, forKey: WrappedKey(key: key))
    }
    
    func removeValue(forKey key: K) {
        cache.removeObject(forKey: WrappedKey(key: key))
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}
