//
//  BodyLabel.swift
//  MovieExplorer
//
//  Created by Yohai on 08/01/2025.
//

import SwiftUI

struct BodyLabel: View {
    var label: String
    
    var body: some View {
        Text(label)
            .font(.body)
            .fontWeight(.medium)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    BodyLabel(label: "Some overview goes here.")
}
