//
//  URLService.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 13.06.2023.
//

import Foundation
import Combine

protocol URLServiceProtocol {
    func request<T: Decodable>(url: URL) -> AnyPublisher<T, Error>
}

class URLService: URLServiceProtocol {
    func request<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
