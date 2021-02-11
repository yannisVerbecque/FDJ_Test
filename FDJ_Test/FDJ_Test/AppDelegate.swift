//
//  AppDelegate.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 10/02/2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow.init(frame: UIScreen.main.bounds)

        let listVC = HomeMainPresenter()
        let navViewController = UINavigationController(rootViewController: listVC)
        navViewController.view.translatesAutoresizingMaskIntoConstraints = false
        navViewController.navigationBar.prefersLargeTitles = true
        
        window.rootViewController = navViewController
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

}

