//
//  CoreDataManager.swift
//  MovieExplorer
//
//  Created by Yohai on 15/01/2025.
//

import UIKit
import CoreData

protocol CoreDataManaging {
    func fetchMoviesFromCoreData() -> [MovieEntity]
    func saveMovieToCoreData(_ movie: MovieEntity)
    func updateMovieInCoreData(_ movie: MovieEntity)
    func deleteMovieFromCoreData(_ movie: MovieEntity)
    func fetchFavoriteMoviesFromCoreData() -> [MovieEntity]
    func saveFavoriteMoviesToCoreData(_ movieEntities: [MovieEntity])
    func removeFavoriteMovieFromCoreData(_ movie: MovieEntity)
}

final class CoreDataManager: CoreDataManaging {
    
    private let containerName: String = "MEModel"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores{ storeDescription, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return persistentContainer
    }()
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
 
    
    init() {
        registerCustomTransformers()
    }
    
    // MARK: Custom Transformers

    private func registerCustomTransformers() {
        ValueTransformer.setValueTransformer(GenreIdsTransfomer(),
                                             forName: NSValueTransformerName("GenreIdsTransfomer"))
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    func fetchMoviesFromCoreData() -> [MovieEntity] {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching movies: \(error)")
            return []
        }
    }
    
    func saveMovieToCoreData(_ movie: MovieEntity) {
        context.insert(movie)
        saveContext()
    }
    
    func updateMovieInCoreData(_ movie: MovieEntity) {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
        
        do {
            if let existingMovie = try context.fetch(fetchRequest).first {
                existingMovie.title = movie.title
                existingMovie.releaseDate = movie.releaseDate
                existingMovie.voteAverage = movie.voteAverage
                existingMovie.genreIds = movie.genreIds
                existingMovie.posterPath = movie.posterPath
                existingMovie.backdropPath = movie.backdropPath
                existingMovie.isFavorite = movie.isFavorite
                saveContext()
            }
        } catch {
            print("Error updating movie: \(error)")
        }
    }
    
    func deleteMovieFromCoreData(_ movie: MovieEntity) {
        context.delete(movie)
        saveContext()
    }
    
    func fetchFavoriteMoviesFromCoreData() -> [MovieEntity] {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %d", true)
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching favorite movies: \(error)")
            return []
        }
    }
    
    func saveFavoriteMoviesToCoreData(_ movieEntities: [MovieEntity]) {
        movieEntities.forEach { context.insert($0) }
        saveContext()
    }
    
    func removeFavoriteMovieFromCoreData(_ movie: MovieEntity) {
        movie.isFavorite = false
        saveContext()
    }
    
    
}
