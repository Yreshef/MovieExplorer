//
//  Movie.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import UIKit

struct Movie: Codable, Hashable {
    let id: Int
    let posterPath: String?
    let releaseDate: Date?
    let title: String
    let overview: String
    let voteAverage: Double
    let genreIds: [Int]
    let backdropPath: String?
    var posterImage: UIImage? = nil
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case overview
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case isFavorite
    }
}

extension Movie {
    
    //// Decodes an instance of `Movie` from a given decoder.
    ///
    /// This initializer attempts to decode all properties of the `Movie` struct
    /// from the provided decoder. If the `release_date` field is not present or cannot
    /// be parsed into a valid `Date`, the `releaseDate` property will be set to `nil`.
    /// Similarly, optional properties like `posterPath` and `backdropPath` will be set
    /// to `nil` if their values are not present or are invalid.
    ///
    /// - Parameter decoder: The `Decoder` instance to decode data from.
    /// - Throws: An error if required properties are missing or if decoding fails.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        posterPath = try? container.decode(String?.self, forKey: .posterPath)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        genreIds = try container.decode([Int].self, forKey: .genreIds)
        backdropPath = try? container.decode(String?.self, forKey: .backdropPath)
        posterImage = nil
        isFavorite = nil
        
        // Safely decode releaseDate
        if let dateString = try? container.decode(String.self, forKey: .releaseDate),
           !dateString.isEmpty {
            releaseDate = DateFormatter.movieAPIFormatter.date(from: dateString)
        } else {
            releaseDate = nil
        }
    }
}

struct MockData {
    static let sampleMovie: Movie = .init(
        id: 12345,
        posterPath: "/samplePoster.jpg",  // Optional; it may be nil for some movies
        releaseDate: DateFormatter.movieAPIFormatter.date(from: "2025-01-01"),
        title: "Sample Movie",
        overview: "Years after witnessing the death of the revered hero Maximus at the hands of his uncle, Lucius is forced to enter the Colosseum after his home is conquered by the tyrannical Emperors who now lead Rome with an iron fist. With rage in his heart and the future of the Empire at stake, Lucius must look to his past to find strength and honor to return the glory of Rome to its people.",
        voteAverage: 7.5,  // Example rating
        genreIds: [28, 12, 14], // Action, Adventure, Fantasy genres
        backdropPath: "/sampleBackdrop.jpg",
        isFavorite: false
    )
    
    static let mockMovies: [Movie] = [
        Movie(
            id: 1,
            posterPath: "/path/to/poster1.jpg",
            releaseDate: DateFormatter.movieAPIFormatter.date(from: "2010-07-16"),
            title: "Inception",
            overview: "A mind-bending thriller about a thief who enters the subconscious to steal secrets.",
            voteAverage: 8.8,
            genreIds: [28, 878, 12], // Action, Science Fiction, Adventure
            backdropPath: "/path/to/backdrop1.jpg",
            isFavorite: false
        ),
        Movie(
            id: 2,
            posterPath: "/path/to/poster2.jpg",
            releaseDate: DateFormatter.movieAPIFormatter.date(from: "2014-02-07"),
            title: "The LEGO Movie",
            overview: "An ordinary LEGO minifigure is mistaken for the most extraordinary person and is recruited to join a quest to stop an evil tyrant.",
            voteAverage: 7.7,
            genreIds: [35, 16, 10751], // Comedy, Animation, Family
            backdropPath: "/path/to/backdrop2.jpg",
            isFavorite: false
        ),
        Movie(
            id: 3,
            posterPath: "/path/to/poster3.jpg",
            releaseDate: DateFormatter.movieAPIFormatter.date(from: "2004-06-25"),
            title: "The Notebook",
            overview: "A young couple falls in love, but circumstances and their differing social classes threaten to keep them apart.",
            voteAverage: 7.8,
            genreIds: [10749, 18], // Romance, Drama
            backdropPath: "/path/to/backdrop3.jpg",
            isFavorite: false
        ),
        Movie(
            id: 4,
            posterPath: "/path/to/poster4.jpg",
            releaseDate: DateFormatter.movieAPIFormatter.date(from: "2008-07-18"),
            title: "The Dark Knight",
            overview: "Batman faces the Joker, a criminal mastermind who seeks to create chaos and disrupt the city's order.",
            voteAverage: 9.0,
            genreIds: [28, 80, 53], // Action, Crime, Thriller
            backdropPath: "/path/to/backdrop4.jpg",
            isFavorite: false
        )
    ]
}

