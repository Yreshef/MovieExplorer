//
//  PersistenceManager.swift
//  MovieExplorer
//
//  Created by Yohai on 15/01/2025.
//

import Foundation

protocol PersistenceManaging {
    
    var coreDataManager: CoreDataManaging { get }
    
    func fetchMovies() -> [Movie]
    func saveMovie(_ movie: Movie)
    func updateMovie(_ movie: Movie)
    func deleteMovie(_ movie: Movie) -> Movie?
    func fetchFavoriteMovies() -> [Movie]
    func saveFavoriteMovies(_ movies: [Movie])
    func removeFavoriteMovie(_ movie: Movie) -> Movie?
}

final class PersistenceManager: PersistenceManaging {
    
    var coreDataManager: CoreDataManaging
    
    init(coreDataManager: CoreDataManaging) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchMovies() -> [Movie] {
        return coreDataManager.fetchMoviesFromCoreData()
    }
    
    func saveMovie(_ movie: Movie) {
        coreDataManager.saveMovieToCoreData(movie)
    }
    
    func updateMovie(_ movie: Movie) {
        coreDataManager.updateMovieInCoreData(movie)
    }
    
    func deleteMovie(_ movie: Movie) -> Movie? {
        coreDataManager.deleteMovieFromCoreData(movie)
        return nil  //TODO: Decide whether to keep return type or not
    }
    
    func fetchFavoriteMovies() -> [Movie] {
        return coreDataManager.fetchFavoriteMoviesFromCoreData()
    }
    
    func saveFavoriteMovies(_ movies: [Movie]) {
        coreDataManager.saveFavoriteMoviesToCoreData(movies)
    }
    
    func removeFavoriteMovie(_ movie: Movie) -> Movie? {
        coreDataManager.removeFavoriteMovieFromCoreData(movie)
        return nil  //TODO: Decide whether to keep return type or not
    }
    
    
}
