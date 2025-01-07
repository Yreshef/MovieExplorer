//
//  APIKeys.swift
//  MovieExplorer
//
//  Created by Yohai on 07/01/2025.
//

import Foundation

struct APIKeys {
    static let movieDBKey: String = {
        guard let filepath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filepath),
              let value = plist["API_KEY"] as? String else {
            fatalError("Couldn't find API_KEY in Secrets.plist")
        }
        return value
    }()
}
