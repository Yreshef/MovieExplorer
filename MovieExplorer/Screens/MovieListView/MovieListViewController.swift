//
//  MovieListViewController.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import UIKit
import Combine
import SwiftUI

class MovieListViewController: UIViewController {
    
    let viewModel: MovieListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: self.view.frame.width, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MEMovieListCell.self, forCellWithReuseIdentifier: MEMovieListCell.reuseIdentifier)
        return collectionView
    }()
    
    init(movieService: MovieServicing, imageService: ImageServicing) {
        viewModel = MovieListViewModel(movieService: movieService, imageService: imageService)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        bindViewModel()
        viewModel.fetchMovies()
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$images
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func prepareDetailView(for movie: Movie, with image: UIImage) -> UIHostingController<MovieDetailView> {
        let movieDetailView = MovieDetailView(movie: movie, moviePosterImage: image) {
            //            self.dismiss(animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        }
        let hostingController = UIHostingController(rootView: movieDetailView)
        hostingController.navigationItem.setHidesBackButton(true, animated: false)
        hostingController.navigationItem.title = movie.title
//        hostingController.modalPresentationStyle = .fullScreen
//        hostingController.modalTransitionStyle = .crossDissolve
        return hostingController
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MEMovieListCell.reuseIdentifier, for: indexPath) as? MEMovieListCell else {
            return UICollectionViewCell()
        }
        let movie = viewModel.movies[indexPath.item]
        cell.configure(with: movie)
        
        if let image = viewModel.images[movie.id] {
            cell.setPosterImage(image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        let image = viewModel.images[movie.id] ?? Images.placeholderPoster
        let hostingController = prepareDetailView(for: movie, with: image)
//        self.present(prepareDetailView(for: movie, with: image), animated: true)
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
}
