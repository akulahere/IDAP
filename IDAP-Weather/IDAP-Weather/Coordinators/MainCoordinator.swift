//
//  MainCoordinator.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 12.06.2023.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Variables

    var navigationController: UINavigationController
    
    // MARK: -
    // MARK: Initialisators

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cityForecastVC = CityForecastViewController()
        cityForecastVC.coordinator = self
        navigationController.pushViewController(cityForecastVC, animated: false)
    }
    
    func showDetailForecast(for indexPath: IndexPath) {
        let detailForecastVC = DetailForecastViewController()
        detailForecastVC.coordinator = self
        // передача данных в detailVC, если необходимо
        navigationController.pushViewController(detailForecastVC, animated: true)
    }
}
