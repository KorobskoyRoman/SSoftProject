//
//  AppDelegate.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 28.02.2022.
//

import UIKit
import CoreData
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("Documents Directory: ",
              FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        FirebaseApp.configure()
//        let navController = UINavigationController()
//        let coordinator = AppCoordinator()
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        coordinator.start(navController: navController, window: window)
//        coordinator.start(window: window)
//        window.makeKeyAndVisible()
//        window = UIWindow(frame: UIScreen.main.bounds)
//        coordinator = AppCoordinator()
        coordinator?.start(window: window)
        window?.makeKeyAndVisible()
        return true
    }
}
