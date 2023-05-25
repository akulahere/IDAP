//
//  AppDelegate.swift
//  IDAP-Square
//
//  Created by Dmytro Akulinin on 23.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        window.rootViewController = MainViewController()
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }

}

