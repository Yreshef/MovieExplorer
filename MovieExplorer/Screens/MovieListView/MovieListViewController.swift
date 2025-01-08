//
//  MovieListViewController.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import UIKit
import Combine

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
    
    init(movieService: MovieServicing) {
        viewModel = MovieListViewModel(movieService: movieService)
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
        collectionView.backgroundColor = .blue
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
        return cell
    }
    
    
}

