//
//  MovieEntity.swift
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
        self.genreIds = movie.genreIds
        self.posterPath = movie.posterPath
        self.backdropPath = movie.backdropPath
        self.isFavorite = movie.isFavorite ?? false
    }
}
