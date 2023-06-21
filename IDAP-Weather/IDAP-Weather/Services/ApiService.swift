//
//  ApiService.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 05.06.2023.
//

import UIKit

typealias ForecastFetchingCompletion = (Result<APIResponse, Error>) -> Void
typealias IconFetchingCompletion = (Result<UIImage, Error>) -> Void

protocol APIServiceProtocol {
    func fetchForecast(lat: Double, lon: Double, completion: @escaping ForecastFetchingCompletion)
    func iconFetchingTask(icon: String, completion: @escaping IconFetchingCompletion) -> CancellableTask?
}


class APIService: APIServiceProtocol {
    
    // MARK: -
    // MARK: Variables

    private let baseURL: String
    private let token: String
    private let urlService: URLServiceProtocol
    private let imageLoader: ImageLoaderProtocol

    // MARK: -
    // MARK: Initialization
    
    init(baseURL: String, token: String, urlService: URLServiceProtocol, imageLoader: ImageLoaderProtocol) {
        self.baseURL = baseURL
        self.token = token
        self.urlService = urlService
        self.imageLoader = imageLoader
    }
    
    // MARK: -
    // MARK: Public

    func fetchForecast(lat: Double, lon: Double, completion: @escaping ForecastFetchingCompletion) {
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

        self.urlService.request(url: urlFromComponents, completion: completion)
    }
    
    func iconFetchingTask(icon: String, completion: @escaping IconFetchingCompletion) -> CancellableTask? {
        let urlStr = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        guard let url = URL(string: urlStr) else {
            return nil
        }
        
        return self.imageLoader.loadImage(from: url, completion: completion)
    }
}
