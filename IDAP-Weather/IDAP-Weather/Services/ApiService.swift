//
//  ApiService.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 05.06.2023.
//

import Foundation

class APIService {
    
    // MARK: -
    // MARK: Variables

    static let shared = APIService()
    let baseURL = "https://api.openweathermap.org/data/2.5"
    let token = "87edb2e6fea049dd604cf126e86556e2"

    // MARK: -
    // MARK: Initialization

    private init() {}
    
    // MARK: -
    // MARK: Public

    func fetchForecast(lat: Double, lon: Double, completion: @escaping (Result<[Forecast], Error>) -> Void) {
        
        let path = "/forecast"
        let urlStr = self.baseURL + path
        
        guard let url = URL(string: urlStr) else {
            return
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: "\(token)")
        ]
                
        guard let urlFromComponents = urlComponents?.url else {
            return
        }

        var request = URLRequest(url: urlFromComponents)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ApiResponse.self, from: data)
                    let forecasts = response.list.map { listItem -> Forecast in
                        let time = listItem.dtTxt
                        let temp = listItem.main.temp
                        let weather = listItem.weather.first?.main ?? ""
                        let iconName = listItem.weather.first?.icon ?? ""
                        return Forecast(time: time, temp: temp, weather: weather, iconName: iconName)
                    }
                    completion(.success(forecasts))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func fetchWeatherIcon(icon: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlStr = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }

        task.resume()
    }
}
