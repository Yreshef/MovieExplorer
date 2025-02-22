//
//  METabBarController.swift
//  MovieExplorer
//
//  Created by Yohai on 06/01/2025.
//

import UIKit

class METabBarController: UITabBarController {
    
    private let dependencyContainer: DependencyContaining
    private let movieListFactory: MovieListViewControllerFactory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    init(container: DependencyContaining) {
        self.dependencyContainer = container
        self.movieListFactory = MovieListViewControllerFactory(dependencyContainer: dependencyContainer)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO: Replace with actual implementation of VCs
    private func configure() {
        view.backgroundColor = .systemCyan
        let firstVC = movieListFactory.createMovieListViewController()
        let firstNC = UINavigationController(rootViewController: firstVC)
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "movieclapper.fill"), tag: 0)
        let secondVC = movieListFactory.createMovieListViewController()
        secondVC.tabBarItem = UITabBarItem(title: "Not Home", image: UIImage(systemName: "popcorn.fill"), tag: 1)
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .systemBackground
        thirdVC.tabBarItem = UITabBarItem(title: "Not Home Alone", image: UIImage(systemName: "gear"), tag: 2)
        viewControllers = [firstNC, secondVC, thirdVC]
        
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
