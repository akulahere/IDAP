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
    private let apiService: APIServiceProtocol
    private let urlService: URLServiceProtocol
    private let imageLoader: ImageLoaderProtocol


    // MARK: -
    // MARK: Initialisators
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.imageLoader = ImageLoader()
        self.urlService = URLService()
        self.apiService = APIService(
            baseURL: "https://api.openweathermap.org/data/2.5",
            token: "87edb2e6fea049dd604cf126e86556e2",
            urlService: urlService,
            imageLoader: imageLoader
        )
    }
    
    func start() {
        
        let cityForecastVC = CityForecastViewController(apiService: self.apiService)
        let handler: EventHandler = { [weak self] event in
            switch event {
                case .displayForecast(let forecast):
                    self?.showDetailForecast(forecast: forecast)
            }
        }
        
        cityForecastVC.setEventHandler(handler: handler)
        self.navigationController.pushViewController(cityForecastVC, animated: false)
    }
    
    func showDetailForecast(forecast: Forecast) {
        let detailForecastVC = DetailedForecastViewController(forecast: forecast, apiService: self.apiService)
        navigationController.pushViewController(detailForecastVC, animated: true)
    }
}
