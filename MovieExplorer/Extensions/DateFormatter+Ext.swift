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
        formatter.dateFormat = DateFormat.dateFormat
        formatter.locale = Locale(identifier: DateFormat.localeIdentifier)
        return formatter
    }()
}
