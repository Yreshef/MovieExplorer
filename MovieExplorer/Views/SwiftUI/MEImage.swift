//
//  MEImage.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import SwiftUI

struct MEImage: View {
    
    var body: some View {
        Image(uiImage: Images.placeholderPoster)
            .resizable()
            .scaledToFit()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 120, height: 90)
            .cornerRadius(8)
    }
}

#Preview {
    MEImage()
}
