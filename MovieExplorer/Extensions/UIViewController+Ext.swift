//
//  UIViewController+Ext.swift
//  MovieExplorer
//
//  Created by Yohai on 10/01/2025.
//

import SwiftUI

extension UIViewController {
    
    func presentMEAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = MEAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
