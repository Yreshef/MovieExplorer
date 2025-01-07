//
//  MESecondaryTitleLabel.swift
//  MovieExplorer
//
//  Created by Yohai on 07/01/2025.
//

import UIKit

class MESecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignement: NSTextAlignment = .natural, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignement
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
