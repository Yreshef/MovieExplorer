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
    var posterPath: String?
    var releaseDate: String //"2023-02-15" - so maybe Date
    var title: String
    var overview: String

    enum CodingKeys: String, CodingKey {
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case overview
    }
}

struct MockData {
    static let sampleMovie: Movie = .init(
        id: 12345,
        originalLanguage: "en",
        originalTitle: "Sample Movie Title",
        posterPath: "/samplePoster.jpg",
        releaseDate: "2025-01-01",
        title: "Sample Movie",
        overview: "Years after witnessing the death of the revered hero Maximus at the hands of his uncle, Lucius is forced to enter the Colosseum after his home is conquered by the tyrannical Emperors who now lead Rome with an iron fist. With rage in his heart and the future of the Empire at stake, Lucius must look to his past to find strength and honor to return the glory of Rome to its people."
    )
    
    static let mockMovies: [Movie] = [
        Movie(
            id: 1,
            originalLanguage: "en",
            originalTitle: "Inception",
            posterPath: "/path/to/poster1.jpg",
            releaseDate: "2010-07-16",
            title: "Inception",
            overview: "Years after witnessing the death of the revered hero Maximus at the hands of his uncle, Lucius is forced to enter the Colosseum after his home is conquered by the tyrannical Emperors who now lead Rome with an iron fist. With rage in his heart and the future of the Empire at stake, Lucius must look to his past to find strength and honor to return the glory of Rome to its people."
        ),
        Movie(
            id: 2,
            originalLanguage: "en",
            originalTitle: "The LEGO Movie",
            posterPath: "/path/to/poster2.jpg",
            releaseDate: "2014-02-07",
            title: "The LEGO Movie",
            overview: "Years after witnessing the death of the revered hero Maximus at the hands of his uncle, Lucius is forced to enter the Colosseum after his home is conquered by the tyrannical Emperors who now lead Rome with an iron fist. With rage in his heart and the future of the Empire at stake, Lucius must look to his past to find strength and honor to return the glory of Rome to its people."
        ),
        Movie(
            id: 3,
            originalLanguage: "en",
            originalTitle: "The Notebook",
            posterPath: "/path/to/poster3.jpg",
            releaseDate: "2004-06-25",
            title: "The Notebook",
            overview: "Years after witnessing the death of the revered hero Maximus at the hands of his uncle, Lucius is forced to enter the Colosseum after his home is conquered by the tyrannical Emperors who now lead Rome with an iron fist. With rage in his heart and the future of the Empire at stake, Lucius must look to his past to find strength and honor to return the glory of Rome to its people."
        ),
        Movie(
            id: 4,
            originalLanguage: "en",
            originalTitle: "The Dark Knight",
            posterPath: "/path/to/poster4.jpg",
            releaseDate: "2008-07-18",
            title: "The Dark Knight",
            overview: "Years after witnessing the death of the revered hero Maximus at the hands of his uncle, Lucius is forced to enter the Colosseum after his home is conquered by the tyrannical Emperors who now lead Rome with an iron fist. With rage in his heart and the future of the Empire at stake, Lucius must look to his past to find strength and honor to return the glory of Rome to its people."
        )
    ]
}
