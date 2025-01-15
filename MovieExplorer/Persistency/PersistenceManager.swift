//
//  PersistenceManager.swift
//  MovieExplorer
//
//  Created by Yohai on 15/01/2025.
//

import Foundation

protocol PersistenceManaging {
    func fetchMovies() -> [Movie]
    func saveMovie(_ movie: Movie)
    func updateMovie(_ movie: Movie)
    func deleteMovie(_ movie: Movie) -> Movie?
    func fetchFavoriteMovies() -> [Movie]
    func saveFavoriteMovies(_ movies: [Movie])
    func removeFavoriteMovie(_ movie: Movie) -> Movie?
}
