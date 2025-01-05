//
//  NetworkError.swift
//  MovieExplorer
//
//  Created by Yohai on 05/01/2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case requestFailure(statusCode: Int)
    case decodingFailure
}
