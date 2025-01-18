//
//  CoreDataManager.swift
//  MovieExplorer
//
//  Created by Yohai on 15/01/2025.
//

import UIKit
import CoreData

protocol CoreDataManaging {
    func fetchMoviesFromCoreData() -> [Movie]
    func saveMovieToCoreData(_ movie: Movie)
    func updateMovieInCoreData(_ movie: Movie)
    func deleteMovieFromCoreData(_ movie: Movie)
    func fetchFavoriteMoviesFromCoreData() -> [Movie]
    func saveFavoriteMoviesToCoreData(_ movies: [Movie])
    func removeFavoriteMovieFromCoreData(_ movie: Movie)
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
    
    // MARK: Public methods
    
    public func fetchMoviesFromCoreData() -> [Movie] {
        let movieEntities = fetchMovieEntities()
        return movieEntities.map { $0.toMovie() }
    }
    
    public func saveMovieToCoreData(_ movie: Movie) {
        if let existingEntity = fetchMovieEntity(by: movie.id) {
            updateMovieEntity(existingEntity, with: movie)
        } else {
            let _ = MovieEntity(from: movie, context: context)
        }
        saveContext()
    }
    
    public func updateMovieInCoreData(_ movie: Movie) {
        guard let existingEntity = fetchMovieEntity(by: movie.id) else {
            print("No movie found to update with ID: \(movie.id)")
            return
        }
        updateMovieEntity(existingEntity, with: movie)
        saveContext()
    }
    
    public func deleteMovieFromCoreData(_ movie: Movie) {
        guard let entity = fetchMovieEntity(by: movie.id) else {
            print("No movie found to delete with ID: \(movie.id)")
            return
        }
        context.delete(entity)
        saveContext()
    }
    
    public func fetchFavoriteMoviesFromCoreData() -> [Movie] {
        let favoriteMovieEntities = fetchFavoriteMovieEntities()
        return favoriteMovieEntities.map { $0.toMovie() }
    }
    
    public func saveFavoriteMoviesToCoreData(_ movies: [Movie]) {
        movies.forEach { saveMovieToCoreData($0) }
    }
    
    public func removeFavoriteMovieFromCoreData(_ movie: Movie) {
        guard let entity = fetchMovieEntity(by: movie.id) else {
            print("No movie found to be removed with ID: \(movie.id)")
            return
        }
        entity.isFavorite = false
        saveContext()
    }
}

// MARK: Private methods

extension CoreDataManager {
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    private func fetchMovieEntities() -> [MovieEntity] {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching movies: \(error)")
            return []
        }
    }
    
    private func fetchMovieEntity(by id: Int) -> MovieEntity? {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            print("Error fetching movie by ID: \(error)")
            return nil
        }
    }
    
    private func fetchFavoriteMovieEntities() -> [MovieEntity] {
        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching favorite movies: \(error)")
            return []
        }
    }
    
    private func updateMovieEntity(_ entity: MovieEntity, with movie: Movie) {
        entity.title = movie.title
        entity.releaseDate = movie.releaseDate
        entity.voteAverage = movie.voteAverage
        entity.posterPath = movie.posterPath
        entity.backdropPath = movie.backdropPath
        
        entity.genreIds = movie.genreIds as NSObject
        
        if let isFavorite = movie.isFavorite {
            entity.isFavorite = isFavorite
        }
    }
    
    // MARK: Purge local data
    #if DEBUG
    func purgeLocalData() {
        let fetchRequests: [NSFetchRequest<NSFetchRequestResult>] = [
            MovieEntity.fetchRequest()
            // Add any other fetch requests you want to purge here
        ]
        for fetchRequest in fetchRequests {
            let deleteRequests = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequests)
                saveContext()
            } catch {
                print("Error purging local data: \(error)")
            }
        }
    }
    #endif
}

// MARK: Entry specific methods

extension CoreDataManager {
    
    private func saveMovieEntity(_ movie: MovieEntity) {
        context.insert(movie)
        saveContext()
    }
    
    private func deleteMovieEntity(_ movie: MovieEntity) {
        context.delete(movie)
        saveContext()
    }
    
    private func saveFavoriteMoviesToCoreData(_ movieEntities: [MovieEntity]) {
        movieEntities.forEach { context.insert($0) }
        saveContext()
    }
    
    private func removeFavoriteMovieFromCoreData(_ movie: MovieEntity) {
        movie.isFavorite = false
        saveContext()
    }
}

