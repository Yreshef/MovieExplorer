//
//  GenreIdsTransfomer.swift
//  MovieExplorer
//
//  Created by Yohai on 15/01/2025.
//

import Foundation

@objc(GenreIdsTransformer)
class GenreIdsTransfomer: ValueTransformer {
    
    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let genreIds = value as? [Int] else { return nil }
        
        return try? NSKeyedArchiver.archivedData(withRootObject: genreIds, requiringSecureCoding: false)
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: data) as? [Int]
    }
}
