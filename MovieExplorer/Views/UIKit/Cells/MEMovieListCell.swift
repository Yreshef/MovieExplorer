//
//  MEMovieListCell.swift
//  MovieExplorer
//
//  Created by Yohai on 07/01/2025.
//

import UIKit

final class MEMovieListCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MEMovieListCellID"
    let posterImageView = MEMoviePosterImageView(frame: .zero)
    let movieTitle = METitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews(posterImageView, movieTitle)
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            posterImageView.heightAnchor.constraint(equalToConstant: 60),
            posterImageView.widthAnchor.constraint(equalToConstant: 60),
            
            movieTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 24),
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func configure(with movie: Movie) {
        posterImageView.image = Images.placeholderPoster
        movieTitle.text = movie.title
    }
    
    public func setPosterImage(_ image: UIImage) {
        posterImageView.image = image
    }
}
