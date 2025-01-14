//
//  MovieListViewController.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import UIKit
import SwiftUI
import Combine

enum MovieListSection: Hashable {
    case movies
}

class MovieListViewController: UIViewController {
    
    let viewModel: MovieListViewModel
    var dataSource: UICollectionViewDiffableDataSource<MovieListSection, Movie>!
    
    private var cancellables = Set<AnyCancellable>()

    private let searchController = UISearchController(searchResultsController: nil)
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: self.view.frame.width, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: Init

    init(movieService: MovieServicing, imageService: ImageServicing) {
        viewModel = MovieListViewModel(movieService: movieService, imageService: imageService)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
    }
    
    // MARK: Methods
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        configureDataSource()
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MovieListSection, Movie>(collectionView: collectionView) { (collectionView, indexPath, movie) -> MovieListCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.reuseIdentifier, for: indexPath) as! MovieListCell
            cell.configure(with: movie)
            return cell
        }
        
        
    }
    
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.updateSnapshot(with: movies)
            }
            .store(in: &cancellables)
        viewModel.imageUpdatePublisher
            .sink { [weak self] movieId in
                self?.updateCell(for: movieId)
            }
            .store(in: &cancellables)
    }
    
    private func updateCell(for movieId: Int) {
        guard let index = viewModel.movies.firstIndex(where: { $0.id == movieId}) else { return }
        let indexPath = IndexPath(item: index, section: 0)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieListCell else { return }
        
        if let image = viewModel.images[movieId] {
            cell.setPosterImage(image)
        }
    }
    
    private func updateSnapshot(with movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<MovieListSection, Movie>()
        snapshot.appendSections([.movies])
        snapshot.appendItems(movies)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func fetchPopularmovies() {
        viewModel.fetchPopularMovies()
    }
    
//    private func updateSnapshot(with movie: Movie) {
//        var snapshot = dataSource.snapshot()
//
//        let movieItems = snapshot.itemIdentifiers(inSection: .movies)
//        
//        if let existingMovie = movieItems.first(where: { $0.id == movie.id }) {
//              snapshot.deleteItems([existingMovie])
//              snapshot.appendItems([movie], toSection: .movies)
//          }
//
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }

    
    private func prepareDetailView(for movie: Movie, with image: UIImage) -> UIHostingController<MovieDetailView> {
        let movieDetailView = MovieDetailView(movie: movie, moviePosterImage: image) {
            //            self.dismiss(animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        }
        let hostingController = UIHostingController(rootView: movieDetailView)
        hostingController.navigationItem.setHidesBackButton(true, animated: false)
        hostingController.navigationItem.title = movie.title
        return hostingController
    }
}

// MARK: CollectionView Delegate&Data Source

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.reuseIdentifier, for: indexPath) as? MovieListCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        let image = viewModel.images[movie.id] ?? Images.placeholderPoster
        let hostingController = prepareDetailView(for: movie, with: image)
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
}

// MARK: Search Results Extension

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.isEmpty else {
            return
              }
        viewModel.updateSearchQuery(query: query)
    }
}
