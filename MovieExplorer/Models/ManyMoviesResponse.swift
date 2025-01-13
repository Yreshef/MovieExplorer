//
//  ManyMoviesResponse.swift
//  MovieExplorer
//
//  Created by Yohai on 13/01/2025.
//

import Foundation

struct ManyMoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

