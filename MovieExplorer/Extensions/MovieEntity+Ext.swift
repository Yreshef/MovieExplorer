//
//  MovieEntity+Ext.swift
//  MovieExplorer
//
//  Created by Yohai on 15/01/2025.
//

import UIKit
import CoreData

extension MovieEntity {
    convenience init(from movie: Movie, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = Int64(movie.id)
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.voteAverage = movie.voteAverage
        self.genreIds = movie.genreIds as NSObject
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.isFavorite = movie.isFavorite ?? false
    }
    
    func toMovie() -> Movie {
        return Movie(
            id: Int(self.id),
            posterPath: self.posterPath ?? "",
            releaseDate: self.releaseDate,
            title: self.title ?? "",
            overview: self.overview ?? "",
            voteAverage: self.voteAverage,
            genreIds: (self.genreIds as? [Int]) ?? [],
            backdropPath: self.backdropPath,
            posterImage: self.posterImageData != nil ? UIImage(data: self.posterImageData!) : nil
        )
    }
}
