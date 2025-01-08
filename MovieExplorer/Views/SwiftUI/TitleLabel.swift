//
//  TitleLabel.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import SwiftUI

struct TitleLabel: View {
    
    var label: String
    
    var body: some View {
        Text(label)
            .font(.largeTitle)
            .fontWeight(.bold)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.6)
    }
}

#Preview {
    TitleLabel(label: "Hello World")
}
