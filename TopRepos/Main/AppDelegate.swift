//
//  AppDelegate.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 17.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // NOTE! This project does not use storyboards and creates its views via pure code instead.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let networkService = SearchAPI()
        
        let repositoriesViewController = RepositoriesViewController(networkService: networkService)
        let navigationViewController = UINavigationController(rootViewController: repositoriesViewController)
        window?.rootViewController = navigationViewController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
}

