//
//  ImageLoader.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 13.06.2023.
//

import UIKit
import Combine

protocol ImageLoaderProtocol {
    func loadImage(from url: URL) -> AnyPublisher<UIImage, Error>
}

class ImageLoader: ImageLoaderProtocol {
    
    // MARK: -
    // MARK: Variables
    
    private let imageCacheManager = CacheImageManager()
    
    enum ImageLoadingError: Error, LocalizedError {
        case failedToConvertDataToImage
        
        var errorDescription: String? {
            switch self {
                case .failedToConvertDataToImage:
                    return "Failed to convert data to image."
            }
        }
    }
    
    // MARK: -
    // MARK: Public
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                if let image = UIImage(data: data) {
                    return image
                } else {
                    throw ImageLoadingError.failedToConvertDataToImage
                }
            }
            .eraseToAnyPublisher()
    }
}

