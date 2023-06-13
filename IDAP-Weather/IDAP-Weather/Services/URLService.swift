//
//  URLService.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 13.06.2023.
//

import Foundation

protocol URLServiceProtocol {
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
    func requestData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)

}

class URLService: URLServiceProtocol {
    
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func requestData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
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