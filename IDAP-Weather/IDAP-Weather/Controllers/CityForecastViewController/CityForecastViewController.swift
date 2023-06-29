//
//  ViewController.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 01.06.2023.
//

import UIKit
import Combine

class CityForecastViewController: UIViewController, RootViewGettable, CityForecastViewDelegate, CityPickerDelegate, ErrorHandler {
    
    // MARK: -
    // MARK: Vairables
    
    typealias RootViewType = CityForecastView
    
    private var eventsHandler: EventHandler?
    private var subscriptions = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    
    var forecasts: [Forecast] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.rootView?.tableView?.reloadData()
            }
        }
    }
    
    var currentCity: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.rootView?.setUpCityLabel(text: self?.currentCity)
            }
        }
    }
    
    // MARK: -
    // MARK: Initialization
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.setupCityPicker(delegate: self)
        
        self.rootView?.setUpTable(delegate: self)
        self.rootView?.backgroundColor = .tintColor
        
        self.fetchForecast(for: .lviv)
    }
    
    // MARK: -
    // MARK: Public
    
    func setEventHandler(handler: @escaping (ViewControllerEvent) -> Void) {
        self.eventsHandler = handler
    }
    
    func fetchForecast(for city: CityPickable) {
        let coordinates = city.coordinates
        DispatchQueue.main.async {
            self.rootView?.showSpinner()
        }
        apiService.fetchForecast(lat: coordinates.latitude, lon: coordinates.longitude)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    self?.rootView?.hideSpinner()
                }
                if case .failure(let error) = completion {
                    DispatchQueue.main.async {
                        self?.present(error: error)
                    }
                }
            } receiveValue: { [weak self] apiResponse in
                self?.forecasts = apiResponse.list.map { listItem -> Forecast in
                    let time = listItem.dtTxt
                    let temp = listItem.main.temp
                    let weather = listItem.weather.first?.main ?? ""
                    let iconName = listItem.weather.first?.icon ?? ""
                    let city = apiResponse.city.name
                    return Forecast(time: time, temp: temp, weather: weather, iconName: iconName, city: city)
                }
                self?.currentCity = apiResponse.city.name
            }
            .store(in: &subscriptions)
    }

    
    func cityPicker(didSelect city: CityPickable) {
        self.fetchForecast(for: city)
    }
}

// MARK: -
// MARK: TableView Delegate

extension CityForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: CityForecastTableViewCell.self, for: indexPath)
        let forecast = self.forecasts[indexPath.row]
        
        DispatchQueue.main.async {
            cell.iconImageView?.showSpinner()
            cell.configure(model: forecast, icon: nil)
        }
        
        let iconFetchingTask = self.apiService.fetchIcon(icon: forecast.iconName)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    DispatchQueue.main.async {
                        self?.present(error: error)
                    }
                }
            } receiveValue: { image in
                DispatchQueue.main.async {
                    cell.configure(model: forecast, icon: image) 
                    cell.iconImageView?.hideSpinner()
                }
            }
        cell.assign(task: iconFetchingTask)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventsHandler?(.displayForecast(forecasts[indexPath.row]))
    }
}


extension CityForecastViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CityPickable.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CityPickable.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCity = CityPickable.allCases[row]
        self.fetchForecast(for: selectedCity)
    }
}
