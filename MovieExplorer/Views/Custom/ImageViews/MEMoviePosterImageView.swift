//
//  MEMoviePosterImageView.swift
//  MovieExplorer
//
//  Created by Yohai on 07/01/2025.
//

import UIKit

class MEMoviePosterImageView: UIImageView {
    
    let placeholderImage = Images.placeholderPoster
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
//        layer.cornerRadius = 10 TODO: Fix display issue with image
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
    }
}
