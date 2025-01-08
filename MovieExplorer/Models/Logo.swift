//
//  Logo.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import Foundation

struct Logo: Decodable {
    var aspectRatio: Double
    var filePath: String
    var height: Int
    var id: String
    var fileType: String
    var voteAverage: Double
    var voteCount: Int
    var width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case id
        case fileType = "file_type"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
