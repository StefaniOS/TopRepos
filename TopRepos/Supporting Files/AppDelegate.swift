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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let fetchingService = NetworkingService()
        let listViewModel = RepositoryListViewModel(fetchingService: fetchingService)
        
        let repositoriesViewController = RepositoryListViewController(viewModel: listViewModel)
        let navigationViewController = UINavigationController(rootViewController: repositoriesViewController)
        window?.rootViewController = navigationViewController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
}

