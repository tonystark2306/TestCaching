//
//  PhotoService.swift
//  TestCaching
//
//  Created by Tran Dat on 26/2/25.
//

import UIKit

class UnsplashService {
    static let urlCacheName = "photoURLCache"
    
    private let accessKey = "fXhodEennpJGuk14k5pplZbIQ67FL__-xItEwZeFbDo"
    private let baseURL = "https://api.unsplash.com/photos"

    func fetchPhotos(isUseCache: Bool, completion: @escaping ([UnsplashPhoto]?, Error?) -> Void) {
        // Tạo URL với query parameters (tuỳ chọn)
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "page", value: "1")
        ]

        guard let url = components?.url else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }

        // Tạo request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        
        // Kiểm tra cache trước khi gọi API
        if isUseCache {
            if let cachedResponse = URLCache.shared.cachedResponse(for: request),
               let photos = try? JSONDecoder().decode([UnsplashPhoto].self, from: cachedResponse.data) {
                completion(photos, nil)
                return
            }
        }
        
        // Gọi API nếu k có cache
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: -1, userInfo: nil))
                return
            }

            // Parse dữ liệu JSON
            do {
                let photos = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                completion(photos, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
