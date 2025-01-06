//
//  SceneDelegate.swift
//  MovieExplorer
//
//  Created by Yohai on 27/12/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let dependencyContainer: DependencyContaining = DependencyContainer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let rootViewController = configureNavController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

extension SceneDelegate {
    
    /// Configures and returns a navigation controller with a root VC
    /// - Returns: A fully configured navigation controller with it's root VC
    private func configureNavController() -> UINavigationController {
        //TODO: Replace placeholder tab bar and nav controller configuration
        let vc = UINavigationController(rootViewController: UITabBarController())
        vc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        vc.navigationBar.topItem?.title = "Wubba Lubba dub-dub"
        vc.overrideUserInterfaceStyle = .dark
        return vc
        
    }
}
