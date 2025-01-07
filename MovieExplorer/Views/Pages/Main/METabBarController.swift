//
//  METabBarController.swift
//  MovieExplorer
//
//  Created by Yohai on 06/01/2025.
//

import UIKit

class METabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemCyan
        
        let firstVC = MovieListViewController()
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        let secondVC = MovieListViewController()
        secondVC.tabBarItem = UITabBarItem(title: "Not Home", image: UIImage(systemName: "person"), tag: 1)
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .systemBackground
        thirdVC.tabBarItem = UITabBarItem(title: "Not Home Alone", image: UIImage(systemName: "gear"), tag: 2)
        viewControllers = [firstVC, secondVC, thirdVC]
        
        //        let appearance = UITabBarAppearance()
        //
        //        // Set the background color to white
        //        appearance.backgroundColor = .clear
        //
        //        // Optional: Customize icon and text colors
        //        appearance.stackedLayoutAppearance.normal.iconColor = .green
        //        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        //        appearance.stackedLayoutAppearance.selected.iconColor = .systemBrown
        //        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        //
        //        // Apply the appearance to the tab bar
        //        tabBar.standardAppearance = appearance
        //
        //        tabBar.scrollEdgeAppearance = appearance
    }
}
