//
//  AppDelegate.swift
//  IDAP-TableView
//
//  Created by Dmytro Akulinin on 26.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let model = self.mainModel()
        let mainViewController = MainViewController(model: model)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navigationController

        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
    
    func mainModel() -> ArrayModel{
        var image: UIImage
        if let pepeImage = UIImage(named: "pepe") {
            image = pepeImage
        } else {
            image = UIImage(systemName: "photo.artframe")!
        }
        
        let dataModels = (0..<10).map { _ in DataModel(text: UUID().uuidString, image: image) }
        return ArrayModel(array: dataModels)
    }

}

