//
//  Movie.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import Foundation

struct Movie: Decodable {
    
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var posterPath: String
    var releaseDate: String
    var title: String

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

struct MockData {
    static let sampleMovie: Movie = .init(
        id: 12345,
        originalLanguage: "en",
        originalTitle: "Sample Movie Title",
        posterPath: "/samplePoster.jpg",
        releaseDate: "2025-01-01",
        title: "Sample Movie"
    )
    
    static let mockMovies: [Movie] = [
        Movie(
            id: 1,
            originalLanguage: "en",
            originalTitle: "Inception",
            posterPath: "/path/to/poster1.jpg",
            releaseDate: "2010-07-16",
            title: "Inception"
        ),
        Movie(
            id: 2,
            originalLanguage: "en",
            originalTitle: "The LEGO Movie",
            posterPath: "/path/to/poster2.jpg",
            releaseDate: "2014-02-07",
            title: "The LEGO Movie"
        ),
        Movie(
            id: 3,
            originalLanguage: "en",
            originalTitle: "The Notebook",
            posterPath: "/path/to/poster3.jpg",
            releaseDate: "2004-06-25",
            title: "The Notebook"
        ),
        Movie(
            id: 4,
            originalLanguage: "en",
            originalTitle: "The Dark Knight",
            posterPath: "/path/to/poster4.jpg",
            releaseDate: "2008-07-18",
            title: "The Dark Knight"
        )
    ]
}
