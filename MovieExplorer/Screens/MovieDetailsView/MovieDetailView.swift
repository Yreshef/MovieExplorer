//
//  MovieDetailView.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import SwiftUI

struct MovieDetailView: View {
    
    var movie: Movie
    var moviePosterImage: UIImage
    
    var body: some View {
        ScrollView {
            VStack {
                MEImage(moviePosterImage: moviePosterImage)
                    .frame(height: 350)
                    .shadow(radius: 15)
                    .padding(.top, 20)
                TitleLabel(label: movie.title)
                BodyLabel(label: movie.overview)
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MovieDetailView(movie: MockData.sampleMovie, moviePosterImage: Images.placeholderPoster)
}
