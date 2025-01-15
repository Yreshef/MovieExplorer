//
//  DateFormatter+Ext.swift
//  MovieExplorer
//
//  Created by Yohai on 15/01/2025.
//

import Foundation

extension DateFormatter {
    
    static let movieAPIFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
