//
//  ViewController.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 01.06.2023.
//

import UIKit

class MainViewController: UIViewController, RootViewGettable, MainViewDelegate {
    
    // MARK: -
    // MARK: Vairables
    
    typealias RootViewType = MainView
    var forecasts: [Forecast] = [] {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.tableView?.reloadData()
            }
        }
    }
    
    var currentCity: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.setUpCityLabel(delegate: self)
            }
        }
    }
    
    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.setUpTable(delegate: self)
        self.rootView?.backgroundColor = .tintColor
        
        APIService.shared.fetchForecast(lat: 49.84, lon: 24.03) {[weak self] result in
            switch result {
                case .success(let apiResponse):
                    self?.forecasts = apiResponse.list.map { listItem -> Forecast in
                        let time = listItem.dtTxt
                        let temp = listItem.main.temp
                        let weather = listItem.weather.first?.main ?? ""
                        let iconName = listItem.weather.first?.icon ?? ""
                        return Forecast(time: time, temp: temp, weather: weather, iconName: iconName)
                    }
                    
                    self?.currentCity = apiResponse.city.name
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    
}

// MARK: -
// MARK: TableView Delegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let forecast = self.forecasts[indexPath.row]
        
        APIService.shared.fetchWeatherIcon(icon: forecast.iconName) { result in
            switch result {
                case .success(let data):
                    let image = UIImage(data: data) ?? UIImage(systemName: "photo.artframe")
                    DispatchQueue.main.async {
                        cell.configure(model: forecast, icon: image)
                    }
                case .failure(let error):
                    print(error)
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
