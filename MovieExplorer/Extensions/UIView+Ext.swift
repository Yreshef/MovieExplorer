//
//  UIView+Ext.swift
//  MovieExplorer
//
//  Created by Yohai on 07/01/2025.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
