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
        let urlService = URLService()
        let imageLoader = ImageLoader()
        let apiService = APIService(
            baseURL: "https://api.openweathermap.org/data/2.5",
            token: "87edb2e6fea049dd604cf126e86556e2",
            urlService: urlService,
            imageLoader: imageLoader
        )
        
        let cityForecastVC = CityForecastViewController(apiService: apiService)
        cityForecastVC.coordinator = self
        navigationController.pushViewController(cityForecastVC, animated: false)
    }
    
    func showDetailForecast(forecast: Forecast, apiService: APIServiceProtocol) {
        let detailForecastVC = DetailedForecastViewController(forecast: forecast, apiService: apiService)
        detailForecastVC.coordinator = self
        navigationController.pushViewController(detailForecastVC, animated: true)
    }
}
