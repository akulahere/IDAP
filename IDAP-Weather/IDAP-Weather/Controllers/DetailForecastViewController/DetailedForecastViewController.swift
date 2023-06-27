//
//  DetailedForecastViewController.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 13.06.2023.
//

import UIKit
import Combine
class DetailedForecastViewController: UIViewController, RootViewGettable, ErrorHandler {
    
    // MARK: -
    // MARK: Variables
    
    var forecast: Forecast
    var apiService: APIServiceProtocol
    private var subscriptions = Set<AnyCancellable>()
    
    typealias RootViewType = DetailedForecastView
    
    // MARK: -
    // MARK: Initialization
    
    init(forecast: Forecast, apiService: APIServiceProtocol) {
        self.forecast = forecast
        self.apiService = apiService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: -
    // MARK: Public
    
    func configureView() {
        
        apiService.fetchIcon(icon: forecast.iconName)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                    case .failure(let error):
                        self?.present(error: error)
                    case .finished:
                        break
                }
            } receiveValue: { [weak self] image in
                guard let forecast = self?.forecast else { return }
                self?.rootView?.configure(model: forecast, icon: image)
            }
            .store(in: &subscriptions)
    }
}
