//
//  MovieEntity+CoreDataProperties.swift
//  
//
//  Created by Yohai on 15/01/2025.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @NSManaged public var id: Int64
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var voteAverage: Double
    @NSManaged public var genreIds: NSObject?
    @NSManaged public var backdropPath: String?
    @NSManaged public var posterImageData: Data?
    @NSManaged public var isFavorite: Bool?

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }
    
    func toMovie() -> Movie {
            return Movie(
                id: Int(id),
                posterPath: posterPath,
                releaseDate: releaseDate,
                title: title,
                overview: overview,
                voteAverage: voteAverage,
                genreIds: genreIds ?? [],
                backdropPath: backdropPath,
                posterImage: posterImageData.flatMap { UIImage(data: $0) } // Convert Data to UIImage
                isFavorite: isFavorite ?? false
            )
        }

        // Convert Movie struct to MovieEntity
        func update(with movie: Movie, in context: NSManagedObjectContext) {
            self.id = Int64(movie.id)
            self.posterPath = movie.posterPath
            self.releaseDate = movie.releaseDate
            self.title = movie.title
            self.overview = movie.overview
            self.voteAverage = movie.voteAverage
            self.genreIds = movie.genreIds
            self.backdropPath = movie.backdropPath
            self.isFavorite = movie.isFavorite
            
            // Convert UIImage to Data and save it
            if let posterImage = movie.posterImage {
                self.posterImageData = posterImage.pngData() // Or use `jpegData(compressionQuality:)` for JPEG
            }
        }

}
