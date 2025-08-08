//
//  ImageLoader.swift
//  TestCaching
//
//  Created by Tran Dat on 26/2/25.
//

import UIKit

class ImageLoader {
    static func loadImage(from urlString: String, isUseCache: Bool, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            // Kiểm tra xem ảnh đã có trong cache chưa
            if isUseCache,
               let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
                completion(cachedImage)
                return
            }
            
            // Tải ảnh từ URL nếu chưa có trong cache
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    // Lưu ảnh vào cache
                    if isUseCache {
                        ImageCache.shared.setImage(image, forKey: urlString)
                    }
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
