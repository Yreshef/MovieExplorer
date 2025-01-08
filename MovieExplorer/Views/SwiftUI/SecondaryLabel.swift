//
//  SecondaryLabel.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import SwiftUI

struct SubtitleLabel: View {
    var label: String
    
    var body: some View {
        Text(label)
            .font(.title3)
            .fontWeight(.semibold)
            .scaledToFit()
            .minimumScaleFactor(0.6)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    SubtitleLabel(label: "Hello, World!")
}
