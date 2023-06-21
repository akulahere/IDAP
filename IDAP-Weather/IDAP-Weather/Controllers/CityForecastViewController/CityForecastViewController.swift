//
//  ViewController.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 01.06.2023.
//

import UIKit

class CityForecastViewController: UIViewController, RootViewGettable, CityForecastViewDelegate, CityPickerDelegate {
    
    // MARK: -
    // MARK: Vairables
    
    typealias RootViewType = CityForecastView
    private var eventsHandler: EventHandler?

//    var coordinator: MainCoordinator?
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
        apiService.fetchForecast(lat: coordinates.latitude, lon: coordinates.longitude) { [weak self] result in
            switch result {
                case .success(let apiResponse):
                    self?.forecasts = apiResponse.list.map { listItem -> Forecast in
                        let time = listItem.dtTxt
                        let temp = listItem.main.temp
                        let weather = listItem.weather.first?.main ?? ""
                        let iconName = listItem.weather.first?.icon ?? ""
                        let city = apiResponse.city.name
                        return Forecast(time: time, temp: temp, weather: weather, iconName: iconName, city: city)
                    }

                    self?.currentCity = apiResponse.city.name
                case .failure(let error):
                    print(error)
            }
        }
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
        let cell: CityForecastTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let forecast = self.forecasts[indexPath.row]
        let defaultIcon = UIImage(systemName: "photo.artframe")
        
        DispatchQueue.main.async {
            cell.configure(model: forecast, icon: defaultIcon)
        }
        
        let imageLoadingTask = self.apiService.iconFetchingTask(icon: forecast.iconName) { result in
            var image: UIImage? = nil
            
            switch result {
            case .success(let fetchedImage):
                image = fetchedImage
            case .failure(let error):
                print("Error fetching image: \(error)")
            }
            
            DispatchQueue.main.async {
                cell.configure(model: forecast, icon: image)
            }
        }
        
        cell.assign(task: imageLoadingTask)
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
