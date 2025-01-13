//
//  AlertView.swift
//  MovieExplorer
//
//  Created by Yohai on 10/01/2025.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let unableToFetchMovie = AlertItem(title: "Unable to fetch movies",
                                                    message:  "Something is wrong with the connection. We are unable to fetch the searched movies.",
                                                    dismissButton: .default(Text("Ok")))
}
