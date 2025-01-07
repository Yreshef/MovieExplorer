//
//  Movie.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import Foundation

struct Movie: Decodable {
    
    var adult: Bool
    var backdropPath: String
    var genreIds: [Int]
    var id: Int
    var originalLanguage: String
    var originalTitle: String
    var overview: String
    var popularity: Double
    var posterPath: String
    var releaseDate: String //"2023-02-15" - so maybe Date
    var title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "posterPath"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct MockData {
    static let sampleMovie: Movie = .init(
        adult: false,
        backdropPath: "/sampleBackdrop.jpg",
        genreIds: [28, 35, 18], // Example genre IDs for Action, Comedy, and Drama
        id: 12345,
        originalLanguage: "en",
        originalTitle: "Sample Movie Title",
        overview: "This is a sample overview of the movie, which gives a brief description of the plot.",
        popularity: 8.9,
        posterPath: "/samplePoster.jpg",
        releaseDate: "2025-01-01",
        title: "Sample Movie",
        video: false,
        voteAverage: 7.4,
        voteCount: 1500
    )
    static let mockMovies: [Movie] = [
        Movie(
            adult: false,
            backdropPath: "/path/to/backdrop1.jpg",
            genreIds: [28, 12, 878],
            id: 1,
            originalLanguage: "en",
            originalTitle: "Inception",
            overview: "A thief with the ability to enter people's dreams and steal their secrets is given the inverse task of planting an idea into the mind of a CEO.",
            popularity: 89.5,
            posterPath: "/path/to/poster1.jpg",
            releaseDate: "2010-07-16",
            title: "Inception",
            video: false,
            voteAverage: 8.8,
            voteCount: 22159
        ),
        Movie(
            adult: false,
            backdropPath: "/path/to/backdrop2.jpg",
            genreIds: [16, 10751, 35],
            id: 2,
            originalLanguage: "en",
            originalTitle: "The LEGO Movie",
            overview: "An ordinary LEGO construction worker is recruited to join a quest to stop an evil tyrant from gluing the universe together.",
            popularity: 76.4,
            posterPath: "/path/to/poster2.jpg",
            releaseDate: "2014-02-07",
            title: "The LEGO Movie",
            video: false,
            voteAverage: 7.5,
            voteCount: 7391
        ),
        Movie(
            adult: false,
            backdropPath: "/path/to/backdrop3.jpg",
            genreIds: [18, 10749],
            id: 3,
            originalLanguage: "en",
            originalTitle: "The Notebook",
            overview: "A young couple falls in love in the 1940s but is tragically separated by war and social differences.",
            popularity: 64.3,
            posterPath: "/path/to/poster3.jpg",
            releaseDate: "2004-06-25",
            title: "The Notebook",
            video: false,
            voteAverage: 7.9,
            voteCount: 7384
        ),
        Movie(
            adult: false,
            backdropPath: "/path/to/backdrop4.jpg",
            genreIds: [28, 80, 18],
            id: 4,
            originalLanguage: "en",
            originalTitle: "The Dark Knight",
            overview: "Batman sets out to dismantle the remaining criminal organizations that plague Gotham. The arrival of a criminal mastermind known as the Joker throws the city into chaos.",
            popularity: 94.2,
            posterPath: "/path/to/poster4.jpg",
            releaseDate: "2008-07-18",
            title: "The Dark Knight",
            video: false,
            voteAverage: 9.0,
            voteCount: 25000
        )
    ]
    
}
