//
//  MEImage.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import SwiftUI

struct MEImage: View {
    
    var moviePosterImage: UIImage?
    
    var body: some View {
        Image(uiImage: moviePosterImage ?? Images.placeholderPoster)
            .resizable()
            .scaledToFit()
            .cornerRadius(8)
    }
}

#Preview {
    MEImage()
}
