//
//  ApiService.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 05.06.2023.
//

import UIKit
import Combine

typealias ResultedCompletion<R> = (Result<R, Error>) -> Void

protocol APIServiceProtocol {
    func fetchForecast(lat: Double, lon: Double) -> AnyPublisher<APIResponse, Error>
    func fetchIcon(icon: String) -> AnyPublisher<UIImage, Error>
}


class APIService: APIServiceProtocol {
    
    // MARK: -
    // MARK: Variables
    
    enum APIServiceError: Error, LocalizedError {
        case invalidURL
        
        var errorDescription: String? {
            switch self {
                case .invalidURL:
                    return "Invalid URL."
            }
        }
    }
    
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

    func fetchForecast(lat: Double, lon: Double) -> AnyPublisher<APIResponse, Error> {
        let path = "/forecast"
        let urlStr = self.baseURL + path
        guard let url = URL(string: urlStr) else {
            return Fail(error: APIServiceError.invalidURL)
                .eraseToAnyPublisher()
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: "\(token)")
        ]
                
        guard let urlFromComponents = urlComponents?.url else {
            return Fail(error: APIServiceError.invalidURL)
                 .eraseToAnyPublisher()
        }

        return self.urlService.request(url: urlFromComponents)
    }
    
    func fetchIcon(icon: String) -> AnyPublisher<UIImage, Error> {
        let urlStr = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        guard let url = URL(string: urlStr) else {
            return Fail(error: APIServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return self.imageLoader.loadImage(from: url)
    }
}
