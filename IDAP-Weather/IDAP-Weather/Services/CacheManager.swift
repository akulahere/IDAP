//
//  CacheManager.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 13.06.2023.
//

import UIKit

class CacheImageManager {
    
    // MARK: -
    // MARK: Variables

    private let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: -
    // MARK: Public

    func cacheImage(_ image: UIImage, for url: URL) {
        guard let encodedUrlString = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        self.imageCache.setObject(image, forKey: encodedUrlString as NSString)
    }
    
    func getCachedImage(for url: URL) -> UIImage? {
        guard let encodedUrlString = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        return self.imageCache.object(forKey: encodedUrlString as NSString)
    }
}
